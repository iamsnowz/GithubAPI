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
    private weak var viewController: UserViewController?
    public var dataStore: UserDataStore?
    
    public func createModule() -> UserViewController {
        let viewController = UserViewController(nibName: "UserViewController", bundle: Bundle(for: type(of: self)))
        let interactor = UserInteractor(userWorker: UserWorker())
        let presenter = UserPresenter()
        viewController.interactor = interactor
        viewController.router = self
        interactor.presenter = presenter
        presenter.viewController = viewController
        self.viewController = viewController
        self.dataStore = interactor
        return viewController
    }
    
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
