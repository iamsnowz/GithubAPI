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
    
    func presentUserResponse(response: [UserModel.Response])
    func presentErrorState(error: ErrorStatus)
}

internal class UserListPresenter {
    weak var viewController: UserListDisplayLogic?
    
}

extension UserListPresenter: UserListPresentationLogic {
    func presentUserResponse(response: [UserModel.Response]) {
        let users: [UserModel.User] = response.map { element in
            return UserModel.User(id: element.id ?? 0,
                                  login: element.login ?? "-",
                                  avatar: URL(string: element.avatarUrl ?? ""),
                                  githubUrl: element.htmlUrl ?? "",
                                  accountType: element.type ?? "",
                                  siteAdmin: element.siteAdmin ?? false ? "true":"false")
        }
        viewController?.displayUser(userList: UserModel.UserList(users: users))
    }
    
    func presentErrorState(error: ErrorStatus) {
        switch error {
        case .networkError:
            let alert = UIAlertController(title: "Something wrong!", message: "the internet connection appears to be offline", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController?.displayNetworkError(alert: alert)
        case .commonError:
            let alert = UIAlertController(title: "Something wrong!", message: "Cannot load data, Please try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController?.displayNetworkError(alert: alert)
        }
    }
}
