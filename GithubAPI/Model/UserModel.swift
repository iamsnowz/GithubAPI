//
//  UserModel.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

public struct UserModel {
    
    public  struct Request {
        
    }
    
    public  struct Response: Decodable {
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
    
    public struct UserList {
        public let users: [User]
    }
    
    public struct User {
        public let id: Int
        public let login: String
        public let avatar: URL?
        public let githubUrl: String
        public let accountType: String
        public let siteAdmin: String
    }

    
}
