//
//  Service.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import Foundation
import Alamofire

public enum API {
    case users(since: Int)
    case user(login: String)
    
    var url: URL {
        switch self {
        case .users(let since):
            return URL(string: "https://api.github.com/users?since=\(since)")!
        case .user(let login):
            return URL(string: "https://api.github.com/users/" + login)!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}

public enum ErrorStatus: Error {
    case networkError
    case commonError
}

public class Service {
    static let shared = Service()
    var alamofireManager: SessionManager?
    let reachability = NetworkReachabilityManager()
    init() {
        let configure = URLSessionConfiguration.default
        configure.timeoutIntervalForRequest = 10
        configure.timeoutIntervalForResource = 10
        alamofireManager = Alamofire.SessionManager(configuration: configure)
    }
    /*
     service for request api from remote server
     */
    func GET<T: Decodable>(request: API, completion: @escaping ((Swift.Result<T, ErrorStatus>) -> Void)) {
        if reachability?.isReachable == false {
            completion(.failure(.networkError))
            return
        }
        
        alamofireManager?.request(request.url, method: request.method).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data, let object = try? JSONDecoder().decode(T.self, from: data) else { return }
                completion(.success(object))
            case .failure(let error):
                completion(.failure(.commonError))
            }
        }
    }
    
}
