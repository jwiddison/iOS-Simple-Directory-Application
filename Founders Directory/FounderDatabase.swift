//
//  FounderDatabase.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/1/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import Foundation
import GRDB

class FounderDatabase {
    
    // MARK: - Constants
    
    struct Constant {
        static let fileName = "founders"
        static let fileExtension = "sqlite"
    }

    // MARK: - Properties

    var dbQueue: DatabaseQueue!

    // MARK: - Singleton
    
    // See http://bit.ly/1tdRybj for a discussion of this singleton pattern.
    static let shared = FounderDatabase()
    
    fileprivate init() {
        // This guarantees that code outside this file can't instantiate a GeoDatabase.
        // So others must use the sharedGeoDatabase singleton.
        dbQueue = try? DatabaseQueue(path: Bundle.main.path(forResource: Constant.fileName,
                                                            ofType: Constant.fileExtension)!)
    }

    // MARK: - Helpers

    //
    // Return a Founder object for the given founder ID.
    //
    func founderForId(_ founderId: Int) -> Founder {
        return dbQueue.inDatabase { (db: Database) -> Founder in
            if let row = Row.fetchOne(db,
                                      "select * from \(Founder.databaseTableName) " +
                "where \(Founder.id) = ?",
                arguments: [ founderId ]) {
                return Founder(row: row)
            }
            
            return Founder()
        }
    }

    func founders() -> [Founder] {
        return dbQueue.inDatabase { (db: Database) -> [Founder] in
            var founders = [Founder]()
            
            for row in Row.fetchAll(db,
                                    "select * from \(Founder.databaseTableName) " +
                                    "order by \(Founder.preferredFullName)") {
                founders.append(Founder(row: row))
            }

            return founders
        }
    }

    func maxFounderVersion() -> Int {
        return dbQueue.inDatabase { (db: Database) -> Int in
            if let row = Row.fetchOne(db,
                        "select MAX(\(Founder.version)) from \(Founder.databaseTableName) ") {
                return row.value(named: Founder.version)
            }

            return 0
        }
    }
}
