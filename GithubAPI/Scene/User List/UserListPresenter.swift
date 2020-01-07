//
//  UserListPresenter.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//
import UIKit

internal protocol UserListPresentationLogic {
    var viewController: UserListDisplayLogic? { get }
}

internal class UserListPresenter {
    weak var viewController: UserListDisplayLogic?
    
}

extension UserListPresenter: UserListPresentationLogic {
    
}
