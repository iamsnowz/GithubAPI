//
//  UserRouter.swift
//  GithubAPI
//
//  Created by iAmSnow on 8/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserRoutingLogic {
    func routeToScene()
}

internal protocol UserDataPassing {
    var dataStore: UserDataStore? { get }
}

public class UserRouter: UserDataPassing {
    public weak var viewController: UserViewController?
    public var dataStore: UserDataStore?
    
}

extension UserRouter: UserRoutingLogic {
    func routeToScene() {
        /*
        let view = AnotherRouter().createModule()
        var destinationDS = view.router?.dataStore
        destinationDS?.value = dataStore?.value
         viewController?.navigationController?.pushViewControler(view, animted: true)
         */
    }
}
