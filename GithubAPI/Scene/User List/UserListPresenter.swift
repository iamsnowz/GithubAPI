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
}

internal class UserListPresenter {
    weak var viewController: UserListDisplayLogic?
    
}

extension UserListPresenter: UserListPresentationLogic {
    func presentUserResponse(response: [UserModel.Response]) {
        let users: [UserModel.User] = response.map { element in
            return UserModel.User(id: element.id ?? 0,
                                  login: element.login ?? "-",
                                  avatar: element.avatarUrl ?? "",
                                  githubUrl: element.htmlUrl ?? "",
                                  accountType: element.type ?? "",
                                  siteAdmin: element.siteAdmin ?? false ? "false":"true")
        }
        viewController?.displayUser(userList: UserModel.UserList(users: users))
    }
}
