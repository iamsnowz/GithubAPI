//
//  UserWorker.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import Foundation

public protocol UserWorkerProtocol {
    func getUserList(id: Int, completion: @escaping ((Result<[UserModel.Response], ErrorStatus>) -> Void))
    func getUser(userLogin: String, completion: @escaping ((Result<UserModel.Response, ErrorStatus>) -> Void))
}

class UserWorker: UserWorkerProtocol {
    
    func getUserList(id: Int, completion: @escaping ((Result<[UserModel.Response], ErrorStatus>) -> Void)) {
        Service.shared.GET(request: .users(since: id)) { (result) in
            completion(result)
        }
    }
    
    func getUser(userLogin: String, completion: @escaping ((Result<UserModel.Response, ErrorStatus>) -> Void)) {
        Service.shared.GET(request: .user(login: userLogin))  { (result) in
            completion(result)
        }
    }
}
