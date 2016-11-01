//
//  SyncHelper.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/1/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation

class SyncHelper {
    var lastSyncTime: Date?

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

    // MARK: - Helpers

    func syncDeletedFounders(_ serverMaxVersion: Int) -> Int {
        /*
        Cursor deleted = getContentResolver().query(
            FounderProvider.Contract.CONTENT_URI,
            new String[]{FounderProvider.Contract._ID},
            FounderProvider.Contract.DELETED + " <> 0", null,
            FounderProvider.Contract.VERSION);
        
        if (deleted != null) {
            boolean success = deleted.moveToFirst();
            
            while (success) {
                int deletedId = deleted.getInt(0);
                
                try {
                String url = SYNC_SERVER_URL + "deletefounder.php" + "?k=" + mSessionToken + "&i=" + deletedId;
                
                String result = HttpHelper.getContent(url).trim();
                serverMaxVersion = Integer.parseInt(result);
                
                if (!result.equals("0")) {
                // Sync to delete on server worked, so remove from local database
                getContentResolver().delete(FounderProvider.Contract.CONTENT_URI,
                FounderProvider.Contract._ID + " = ?", new String[]{deletedId + ""});
                }
                } catch (Exception e) {
                Log.d(TAG, "syncDeletedFounders: unable to delete " + deletedId);
                }

                success = deleted.moveToNext()
            }
            
            deleted.close()
        }
        */
        return serverMaxVersion
    }

    func syncDirtyFounders(_ serverMaxVersion: Int) -> Int {
        return serverMaxVersion
    }

    func syncNewFounders(_ serverMaxVersion: Int) -> Int {
        return serverMaxVersion
    }

    func syncServerFounderUpdates(_ maxVersion: Int, _ serverMaxVersion: Int) -> Bool {
        return false
    }
}
