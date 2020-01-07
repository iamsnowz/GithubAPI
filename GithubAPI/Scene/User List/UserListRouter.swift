//
//  UserListRouter.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserListRoutingLogic {
    func routeToScene()
}

internal protocol UserListDataPassing {
    var dataStore: UserListDataStore? { get }
}

public class UserListRouter: UserListDataPassing {
    private weak var viewController: UserListViewController?
    public var dataStore: UserListDataStore?
    
    public func createModule() -> UserListViewController {
        let viewController = UserListViewController(nibName: "UserListViewController", bundle: Bundle(for: type(of: self)))
        let interactor = UserListInteractor(userWorker: UserWorker())
        let presenter = UserListPresenter()
        viewController.interactor = interactor
        viewController.router = self
        interactor.presenter = presenter
        presenter.viewController = viewController
        self.viewController = viewController
        self.dataStore = interactor
        return viewController
    }
    
}

extension UserListRouter: UserListRoutingLogic {
    func routeToScene() {
        /*
         let view = AnotherRouter().createModule()
         var destinationDS = view.router?.dataStore
         destinationDS?.value = dataStore?.value
         viewController?.navigationController?.pushViewControler(view, animted: true)
         */
    }
}
