//
//  UserPresenter.swift
//  GithubAPI
//
//  Created by iAmSnow on 8/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//
import UIKit

internal protocol UserPresentationLogic {
    var viewController: UserDisplayLogic? { get }
    
    func presentUserResponse(response: UserModel.Response)
    func presentErrorState(error: ErrorStatus)
}

internal class UserPresenter {
    weak var viewController: UserDisplayLogic?
    
}

extension UserPresenter: UserPresentationLogic {
    func presentUserResponse(response: UserModel.Response) {
        let id = response.id ?? 0
        let login = response.login ?? "-"
        let avatar = URL(string: response.avatarUrl ?? "-")
        let githubUrl = response.htmlUrl ?? "-"
        let accountType = response.type ?? "-"
        let siteAdmin = response.siteAdmin ?? false ? "true":"false"
        let user = UserModel.User(id: id, login: login, avatar: avatar, githubUrl: githubUrl, accountType: accountType, siteAdmin: siteAdmin)
        viewController?.displayUser(user: user)
    }
    
    func presentErrorState(error: ErrorStatus) {
        switch error {
        case .networkError:
            let alert = UIAlertController(title: "Something wrong!", message: "the internet connection appears to be offline.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                self?.viewController?.backToPrevious()
            }))
            viewController?.displayNetworkError(alert: alert)
        case .commonError:
            let alert = UIAlertController(title: "Something wrong!", message: "Cannot load data, Please try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                self?.viewController?.backToPrevious()
            }))
            viewController?.displayNetworkError(alert: alert)
        }
    }
}
