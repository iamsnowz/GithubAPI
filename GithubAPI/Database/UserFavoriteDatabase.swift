//
//  UserFavoriteDatabase.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class UserFavoriteDatabase: Object {
    static let shared = UserFavoriteDatabase()
    let KEY = "login"
    @objc dynamic var login: String = ""
    
    private convenience init(user: UserModel.User) {
        self.init()
        self.login = user.login
    }
    
    func findFavorite(user: UserModel.User) -> Results<UserFavoriteDatabase> {
        let findObject: Results<UserFavoriteDatabase> = RealmDatabase.shared.findObject(field: KEY, value: user.login)
        return findObject
    }
    
    func updateFavorite(user: UserModel.User) -> UIImage? {
        let imageFavorite = findFavorite(user: user).isEmpty ? "star" : "star.fill"
        guard let image = UIImage(systemName: imageFavorite) else { return nil }
        return image
    }
    
    func modify(user: UserModel.User) {
        let findObject = findFavorite(user: user)
        if findObject.isEmpty {
            create(user: user)
        } else {
            delete(object: findObject.first)
        }
    }
    
    private func create(user: UserModel.User) {
        let favorite = UserFavoriteDatabase(user: user)
        RealmDatabase.shared.create(favorite)
    }
    
    private func delete(object: UserFavoriteDatabase?) {
        guard let obj = object else { return }
        RealmDatabase.shared.delete(obj) {
            
        }
    }
    
    func getFavoriteObject() -> Results<UserFavoriteDatabase>  {
        let object: Results<UserFavoriteDatabase> = RealmDatabase.shared.getObject()
        return object
    }

}
