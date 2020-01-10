//
//  UserListRouter.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserListRoutingLogic {
    func routeToUser()
}

internal protocol UserListDataPassing {
    var dataStore: UserListDataStore? { get }
}

public class UserListRouter: UserListDataPassing {
    public weak var viewController: UserListViewController?
    public var dataStore: UserListDataStore?
    
}

extension UserListRouter: UserListRoutingLogic {
    func routeToUser() {
        let view = UserViewController()
        view.interactor?.favoriteHandler = viewController?.updateFavoriteHandler
        var destinationDS = view.router!.dataStore!
        passData(source: dataStore!, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func passData(source: UserListDataStore, destination: inout UserDataStore) {
        destination.userLogin = source.selectedUserLogin
    }
}
