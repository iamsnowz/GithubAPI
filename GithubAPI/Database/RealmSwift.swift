//
//  RealmSwift.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}

public class RealmDatabase {
    
    private init() {
        configure()
    }
    
    public static let shared = RealmDatabase()
    var realm: Realm!
    
    public func configure() {
        var config = Realm.Configuration.defaultConfiguration
        config.schemaVersion = UInt64(Date().timeIntervalSince1970)
        realm = try? Realm(configuration: config)
    }
    
    public func create<T: Object>(_ object: T) {
        do {
            try realm.safeWrite {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    public func delete<T: Object>(_ object: T, completion: (() -> Void)) {
        do {
            try realm.safeWrite {
                realm.delete(object)
                completion()
            }
        } catch {
            print(error)
        }
    }
    
    public func deleteAllTable<T: Object>(_ object: Results<T>) {
        
        do {
            try realm.safeWrite {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
    
    public func deleteAllObject() {
        do {
            try realm.safeWrite {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    public func getObject<T: Object>() -> Results<T> {
        let results = realm.objects(T.self)
        return results
    }
    
    public func findObject<T: Object>(field: String, value: String) -> Results<T> {
        let predicate = NSPredicate(format: "%K = %@", field, value)
        return realm.objects(T.self).filter(predicate)
    }
    
    public func findObjectPrimary<T: Object>(key: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    
    public func update(completion: (() -> Void)) {
        do {
            try realm.safeWrite {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
