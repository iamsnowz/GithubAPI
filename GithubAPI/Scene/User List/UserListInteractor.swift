//
//  UserListInteractor.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserListBusinessLogic {
    
}

public protocol UserListDataStore {
    
}

internal class UserListInteractor: UserListDataStore {
    var presenter: UserListPresentationLogic?
    
}

extension UserListInteractor: UserListBusinessLogic {
    
}
