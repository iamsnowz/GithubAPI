//
//  UserModel.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal struct UserModel {
    
    internal struct Request {
        
    }
    
    internal struct Response: Decodable {
        var login: String?
        var id: Int?
        var avatarUrl: String?
        var htmlUrl: String?
        var type: String?
        var siteAdmin: Bool?
        
        enum CodingKeys: String, CodingKey {
            case avatarUrl = "avatar_url"
            case htmlUrl = "html_url"
            case siteAdmin = "site_admin"
            case login
            case id
            case type
        }
    }
    
    internal struct Error: Decodable {
        
    }
    
    internal struct ViewModel {
        
    }
    
}
