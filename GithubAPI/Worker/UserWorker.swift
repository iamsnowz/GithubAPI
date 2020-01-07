//
//  UserWorker.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import Foundation

public protocol UserWorkerProtocol {
    func getUserList(id: Int, completion: @escaping ((Result<[UserModel.Response], UserModel.ErrorStatus>) -> Void))
}

class UserWorker: UserWorkerProtocol {
    
    func getUserList(id: Int, completion: @escaping ((Result<[UserModel.Response], UserModel.ErrorStatus>) -> Void)) {
        Service.shared.GET(request: .users(since: id)) { (response: [UserModel.Response]?) in
            if let response = response {
                completion(.success(response))
            } else {
                completion(.failure(.network))
            }
            
        }
    }
}
