//
//  SyncHelper.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/1/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

typealias JSONObject = [String : Any?]
typealias JSONArray = [Any?]

class SyncHelper {
    
    // MARK: - Constants

    private struct Command {
        static let add = "addfounder"
        static let delete = "deletefounder"
        static let getupdates = "getupdatessince"
        static let update = "updatefounder"
    }

    private struct Constants {
        static let baseSyncUrl = "https://scriptures.byu.edu/founders/v4/"
        static let failureCode = "0"
        static let sessionTokenKey = "sessionKey"
    }
    
    private struct Parameter {
        static let id = "i"
        static let maxVersion = "x"
        static let sessionToken = "k"
        static let version = "v"
    }

    // MARK: - Properties
    
    var lastSyncTime: Date?
    var sessionToken: String?
    
    // MARK: - Singleton
    
    static let shared = SyncHelper()
    
    fileprivate init() {
        loadSessionFromPreferences()
    }
    

    // MARK: - Public API
    
    func synchronizeFounders() -> Bool {
        lastSyncTime = Date()
    
        let maxVersion = FounderDatabase.shared.maxFounderVersion()
        var serverMaxVersion = 0

        // Note: In the production version, we won't let users delete
        //       or create founder records, only update.
        serverMaxVersion = syncDeletedFounders(serverMaxVersion);
        serverMaxVersion = syncNewFounders(serverMaxVersion);
        serverMaxVersion = syncDirtyFounders(serverMaxVersion);
        return syncServerFounderUpdates(maxVersion, serverMaxVersion);
    }

    // MARK: - Private helpers

    private func allFieldsMap() -> [String : String] {
        var allFields = [String : String]()
        var index = 0
    
        for field in Founder.allFieldsIdVersion {
            allFields["f\(index)"] = field
            index += 1
        }

        return allFields
    }

    //
    // Download and save locally a photo for a Founder or spouse.
    //
    private func downloadPhoto(id: Int, isSpouse: Bool) {
//        PhotoManager photoManager = PhotoManager.getSharedPhotoManager(getApplicationContext());
//        String photoUrl = SYNC_SERVER_URL + "photo.php?k=" + mSessionToken + "&i=" + id;
//        Bitmap photoBitmap;
//        
//        photoUrl += "&f=" + (isSpouse ? "spouse" : "founder");
//        photoBitmap = HttpHelper.getBitmap(photoUrl);
//        
//        if (photoBitmap != null) {
//            if (isSpouse) {
//                photoManager.saveSpousePhotoForFounderId(id, photoBitmap);
//            } else {
//                photoManager.savePhotoForFounderId(id, photoBitmap);
//            }
//        }
    }
    
    //
    // Download the Founder and/or spouse photo(s) for this Founder record.
    //
    private func downloadPhotos(values: [String : String]) {
        if let idString = values[Founder.Field.id], let id = Int(idString) {
            downloadPhoto(id: id, isSpouse: false)
            downloadPhoto(id: id, isSpouse: true)
        }
    }

    private func loadSessionFromPreferences() {
        sessionToken = UserDefaults.standard.string(forKey: Constants.sessionTokenKey)
        sessionToken = "41471165af5bb678bf58467811505450"
    }

    private func syncDeletedFounders(_ serverMaxVersion: Int) -> Int {
        guard let token = sessionToken else {
            return serverMaxVersion
        }

        var maxVersion = serverMaxVersion

        for deletedId in FounderDatabase.shared.deletedFounderIds() {
            let url = syncUrl(forCommand: Command.delete,
                              withArguments: [Parameter.sessionToken : token,
                                              Parameter.id : "\(deletedId)"])
            HttpHelper.shared.getContent(urlString: url, failureCode: Constants.failureCode) { (content) in
                maxVersion = Int(content) ?? maxVersion

                if content != Constants.failureCode {
                    // Sync to delete on server worked, so remove from local database
                    FounderDatabase.shared.delete(deletedId)
                }
            }
        }

        return maxVersion
    }

    private func syncDirtyFounders(_ serverMaxVersion: Int) -> Int {
        guard let token = sessionToken else {
            return serverMaxVersion
        }

        var maxVersion = serverMaxVersion

        for dirtyId in FounderDatabase.shared.dirtyFounderIds() {
            var arguments = [Parameter.sessionToken : token,
                             Parameter.id : "\(dirtyId)"]
            let fieldKeyMap = allFieldsMap()
            let founderRow = FounderDatabase.shared.founderRecordForId(dirtyId)

            for (key, field) in fieldKeyMap {
                if let value = founderRow.value(named: field) as? String {
                    arguments[key] = value
                } else {
                    arguments[key] = ""
                }
            }

            arguments[Parameter.version] = founderRow.value(named: Founder.Field.version)

            let url = syncUrl(forCommand: Command.update, withArguments: arguments)

            HttpHelper.shared.postContent(urlString: url) { (data) in
                if let founders = try? JSONSerialization.jsonObject(with: data!,
                                                        options: .allowFragments) as! JSONObject {
                    let founder = FounderDatabase.shared.founderForId(dirtyId)
                    let upResult = uploadPhoto(id: dirtyId, founder: founder, isSpouse: false) ||
                                   uploadPhoto(id: dirtyId, founder: founder, isSpouse: true)

                    // Sync to add on server worked, so update in local database

                    guard let version = founders[Founder.Field.version] as? String else {
                        return
                    }

                    founder.new = Int(Founder.Flag.existing)!

                    // If we had trouble uploading an image, this record is still dirty
                    founder.dirty = Int(upResult ? Founder.Flag.clean : Founder.Flag.dirty)!
                    founder.update(from: founders)

                    maxVersion = Int(version) ?? maxVersion

                    FounderDatabase.shared.update(founder)
                }
            }
        }

        return maxVersion
    }

    private func syncNewFounders(_ serverMaxVersion: Int) -> Int {
        guard let token = sessionToken else {
            return serverMaxVersion
        }

        var maxVersion = serverMaxVersion

        for newId in FounderDatabase.shared.newFounderIds() {
            var arguments = [Parameter.sessionToken : token]
            let fieldKeyMap = allFieldsMap()
            let founderRow = FounderDatabase.shared.founderRecordForId(newId)

            for (key, field) in fieldKeyMap {
                if let value = founderRow.value(named: field) as? String {
                    arguments[key] = value
                } else {
                    arguments[key] = ""
                }
            }

            let url = syncUrl(forCommand: Command.add, withArguments: arguments)
            
            HttpHelper.shared.postContent(urlString: url) { (data) in
                if let serverNew = try? JSONSerialization.jsonObject(with: data!,
                                                                     options: .allowFragments) as! JSONObject {
                    // Sync to add on server worked, so replace in local database
                    
                    // TODO: There could be an issue here.  Make sure this ID doesn't already exist.
                    guard let newIdValue = serverNew[Founder.Field.id] as? String,
                        let version = serverNew[Founder.Field.version] as? String else {
                            return
                    }
                    
                    let founder = FounderDatabase.shared.founderForId(newId)
                    
                    founder.id = Int(newIdValue)!
                    founder.new = Int(Founder.Flag.existing)!
                    founder.dirty = Int(Founder.Flag.clean)!
                    founder.version = Int(version)!
                    
                    maxVersion = Int(version) ?? maxVersion
                    
                    FounderDatabase.shared.update(founder)

                    _ = uploadPhoto(id: newId, founder: founder, isSpouse: false)
                    _ = uploadPhoto(id: newId, founder: founder, isSpouse: true)
                }
            }
        }
        
        return maxVersion
    }

    private func syncServerFounderUpdates(_ maxVersion: Int, _ serverMaxVersion: Int) -> Bool {
        var changesMade = false

        guard let token = sessionToken else {
            return changesMade
        }

        // Ask the server for updates between our max at the beginning of the sync and
        // the new max on the server
        let arguments = [Parameter.sessionToken : token,
                         Parameter.version : "\(maxVersion)",
                         Parameter.maxVersion : "\(serverMaxVersion)"]
        let url = syncUrl(forCommand: Command.getupdates, withArguments: arguments)

        HttpHelper.shared.getContent(urlString: url) { (data) in
            if let founders = try? JSONSerialization.jsonObject(with: data!,
                                                        options: .allowFragments) as! JSONArray {
                for i in 0 ..< founders.count {
                    if let founderObject = founders[i] as? JSONObject {
                        changesMade = true

                        let id = Int(founderObject[Founder.Field.id] as! NSNumber)

                        let founder = FounderDatabase.shared.founderForId(id)

                        if let deletedValue = founderObject[Founder.Field.deleted] as? String {
                            if deletedValue == Founder.Flag.deleted {
                                FounderDatabase.shared.delete(id)
                                continue
                            }
                        }

                        // Attempt to update
                        if founder.id > 0 {
                            // NEEDSWORK: copy non-ID values into founder object
                            FounderDatabase.shared.update(founder)
                            continue
                        }

                        FounderDatabase.shared.insert(founder, from: founderObject)

//                        downloadPhotos(founder)
                    }
                }
            }
        }

        return changesMade
    }

    private func syncUrl(forCommand command: String, withArguments arguments: [String : String]) -> String {
        var url = "\(Constants.baseSyncUrl)\(command).php"

        if arguments.count > 0 {
            var first = true
            url += "?"

            for (key, value) in arguments {
                if first {
                    first = false
                } else {
                    url += "&"
                }

                url += "\(key)=\(value)"
            }
        }

        return url
    }
    
    private func uploadPhoto(id: Int, founder: Founder, isSpouse: Bool) -> Bool {
        // NEEDSWORK: implement it
        return true
    }
}
