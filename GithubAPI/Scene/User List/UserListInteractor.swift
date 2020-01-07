//
//  UserListInteractor.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserListBusinessLogic {
    func refresh()
    func getUser()
    func selectUser(at indexPath: IndexPath)
    func updateUserList(userList: UserModel.UserList)
}

public protocol UserListDataStore {
    var next: Int { get set }
    var selectedId: Int? { get set }
    var userList: UserModel.UserList? { get set }
}

internal class UserListInteractor: UserListDataStore {
    
    init(userWorker: UserWorkerProtocol) {
        self.userWorker = userWorker
    }
    
    var presenter: UserListPresentationLogic?
    var userWorker: UserWorkerProtocol?
    
    var next: Int = 0
    var selectedId: Int?
    var userList: UserModel.UserList?
}

extension UserListInteractor: UserListBusinessLogic {
    
    func refresh() {
        next = 0
        userWorker?.getUserList(id: next, completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.presentUserResponse(response: response)
            case .failure(let error):
                break
            }
        })
    }
    
    func getUser() {
        presenter?.viewController?.showLoading()
        userWorker?.getUserList(id: next, completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.presentUserResponse(response: response)
            case .failure(let error):
                break
            }
            self?.presenter?.viewController?.hideLoading()
        })
    }
    
    func selectUser(at indexPath: IndexPath) {
        guard let list = userList else { return }
        selectedId = list.users[indexPath.row].id
    }
    
    func updateUserList(userList: UserModel.UserList) {
        self.userList = userList
    }
    
}
