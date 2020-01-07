//
//  UserListViewController.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit

internal protocol UserListDisplayLogic: class {

}

public class UserListViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    @IBOutlet private var tableView: UITableView!
    // MARK: - Properties
    
    internal var interactor: (UserListBusinessLogic & UserListDataStore)?
    internal var router: (UserListRoutingLogic & UserListDataPassing)?
    
    // MARK: - View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        //tableView.register(UINib(nibName: <#T##String#>, bundle: <#T##Bundle?#>), forCellReuseIdentifier: <#T##String#>)
    }
    
    // MARK: - Setup View
    
    // MARK: - Action
    
}

// MARK: - Start of Extension Any
extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Sample \(indexPath.row)"
        return cell
    }
    
}
// MARK: - End of Extension Any
// MARK: - View Protocol
extension UserListViewController: UserListDisplayLogic {
    
}
