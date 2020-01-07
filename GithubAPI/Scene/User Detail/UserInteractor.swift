//
//  UserInteractor.swift
//  GithubAPI
//
//  Created by iAmSnow on 8/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserBusinessLogic {
    func getUser()
    func favoriteModify()
    func updateFavorite(user: UserModel.User)
}

public protocol UserDataStore {
    var userLogin: String? { get set }
    var user: UserModel.User? { get set }
    var favoriteHandler: (() -> Void)? { get set }
}

internal class UserInteractor: UserDataStore {
    
    init(userWorker: UserWorkerProtocol) {
        self.userWorker = userWorker
    }
    
    var presenter: UserPresentationLogic?
    var userWorker: UserWorkerProtocol?
    var userLogin: String?
    var user: UserModel.User?
    var favoriteHandler: (() -> Void)?
}

extension UserInteractor: UserBusinessLogic {
    func getUser() {
        guard let userLogin = userLogin else { return }
        presenter?.viewController?.showLoading()
        userWorker?.getUser(userLogin: userLogin, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter?.presentUserResponse(response: response)
            case .failure(let error):
                self?.presenter?.presentErrorState(error: error)
            }
            self?.presenter?.viewController?.hideLoading()
        })
    }
    
    func favoriteModify() {
        guard let user = user else { return }
        UserFavoriteDatabase.shared.modify(user: user)
        updateFavorite(user: user)
        favoriteHandler?()
    }
    
    func updateFavorite(user: UserModel.User) {
        guard let image = UserFavoriteDatabase.shared.updateFavorite(user: user) else { return }
        presenter?.viewController?.displayFavorite(image: image)
    }
}
