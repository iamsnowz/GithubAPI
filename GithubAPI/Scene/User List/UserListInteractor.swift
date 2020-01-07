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
    func pagination(indexPath: IndexPath)
    func selectUser(at indexPath: IndexPath)
    func updateUserList(userList: UserModel.UserList)
    func updateFavorite(tableView: UITableView)
}

public protocol UserListDataStore {
    var next: Int { get set }
    var selectedUserLogin: String? { get set }
    var userList: UserModel.UserList? { get set }
    var indexPath: IndexPath? { get set }
}

internal class UserListInteractor: UserListDataStore {
    
    init(userWorker: UserWorkerProtocol) {
        self.userWorker = userWorker
    }
    
    var presenter: UserListPresentationLogic?
    var userWorker: UserWorkerProtocol?
    
    var next: Int = 0
    var selectedUserLogin: String?
    var userList: UserModel.UserList?
    var indexPath: IndexPath?
}

extension UserListInteractor: UserListBusinessLogic {
    /*
     pull to refresh user
     */
    func refresh() {
        next = 0
        userList = nil
        userWorker?.getUserList(id: next, completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.presentUserResponse(response: response)
            case .failure(let error):
                self?.presenter?.presentErrorState(error: error)
            }
            self?.presenter?.viewController?.hideLoading()
        })
    }
    
    /*
     get user github
     */
    func getUser() {
        presenter?.viewController?.showLoading()
        userWorker?.getUserList(id: next, completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.presentUserResponse(response: response)
            case .failure(let error):
                self?.presenter?.presentErrorState(error: error)
            }
            self?.presenter?.viewController?.hideLoading()
        })
    }
    
    /*
     Logic for paginate
     */
    func pagination(indexPath: IndexPath) {
        let lastElement = indexPath.row + 1
        if lastElement == userList?.users.count {
            presenter?.viewController?.showPaginateLoading()
            guard let lastUser = userList?.users.last else { return }
            next = lastUser.id
            userWorker?.getUserList(id: next, completion: { [weak self] (result) in
                switch result {
                case .success(let response):
                    self?.presenter?.presentUserResponse(response: response)
                case .failure(let error):
                    self?.presenter?.presentErrorState(error: error)
                }
                self?.presenter?.viewController?.hideLoading()
            })
        }
    }
    
    /*
     selected user for see more detail
     */
    func selectUser(at indexPath: IndexPath) {
        guard let list = userList else { return }
        self.indexPath = indexPath
        selectedUserLogin = list.users[indexPath.row].login
    }
    
    func updateUserList(userList: UserModel.UserList) {
        if self.userList == nil {
            self.userList = userList
        } else {
            self.userList?.users.append(contentsOf: userList.users)
        }
    }
    
    /*
     handle favorite user
     */
    func updateFavorite(tableView: UITableView) {
        guard let indexPath = indexPath else { return }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
