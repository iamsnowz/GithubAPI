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
}
