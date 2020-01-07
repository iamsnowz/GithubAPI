//
//  UserListViewController.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

internal protocol UserListDisplayLogic: class {
    func displayUser(userList: UserModel.UserList)
    func displayNetworkError(alert: UIAlertController)
    func showLoading()
    func hideLoading()
    func showPaginateLoading()
}

public class UserListViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: UITableView!
    // MARK: - Properties
    
    internal var interactor: (UserListBusinessLogic & UserListDataStore)?
    internal var router: (UserListRoutingLogic & UserListDataPassing)?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    // MARK: - View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.getUser()
    }
    
    // MARK: - Setup View
    private func setupView() {
        title = "Github Users"
        view.backgroundColor = UIColor.systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.refreshControl = refreshControl
        
    }
    
    // MARK: - Action
    @objc
    private func pullToRefresh() {
        interactor?.refresh()
    }
    
    func updateFavoriteHandler() {
        interactor?.updateFavorite(tableView: tableView)
    }
}

// MARK: - Start of Extension Any
extension UserListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.selectUser(at: indexPath)
        router?.routeToUser()
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        interactor?.pagination(indexPath: indexPath)
    }
}

extension UserListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.userList?.users.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath)
        configure(for: cell, at: indexPath)
        return cell
    }
    
    private func configure(for cell: UITableViewCell, at indexPath: IndexPath) {
        let row = indexPath.row
        if let cell = cell as? UserTableViewCell {
            guard let list = interactor?.userList, let user = interactor?.userList?.users[row] else { return }
            cell.updateUser(user: user)
            cell.updateIndex(tag: row)
            cell.updateUserList(userList: list)
        }
    }
    
}
// MARK: - End of Extension Any
// MARK: - View Protocol
extension UserListViewController: UserListDisplayLogic {
    func displayUser(userList: UserModel.UserList) {
        interactor?.updateUserList(userList: userList)
        tableView.reloadData()
    }
    
    func showLoading() {
        let width = UIScreen.main.bounds.width
        let size = CGSize(width: width * 0.25 , height: width * 0.25)
        startAnimating(size, type: .circleStrokeSpin, fadeInAnimation: nil)
    }
    
    func showPaginateLoading() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: 44, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
    }
    
    func hideLoading() {
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
        refreshControl.endRefreshingWhenReloadData()
        stopAnimating()
    }
    
    func displayNetworkError(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}
