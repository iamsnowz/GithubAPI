//
//  UserViewController.swift
//  GithubAPI
//
//  Created by iAmSnow on 8/1/2563 BE.
//  Copyright (c) 2563 iAmSnow. All rights reserved.
//

import UIKit
import Kingfisher
import NVActivityIndicatorView

internal protocol UserDisplayLogic: class {
    func displayUser(user: UserModel.User)
    func displayFavorite(image: UIImage)
    func showLoading()
    func hideLoading()
}

public class UserViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userLoginLabel: UILabel!
    @IBOutlet var userGithubLabel: UILabel!
    @IBOutlet var userAccountTypeLabel: UILabel!
    @IBOutlet var userSiteadminLabel: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    // MARK: - Properties
    
    internal var interactor: (UserBusinessLogic & UserDataStore)?
    internal var router: (UserRoutingLogic & UserDataPassing)?
    
    lazy var favoriteItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(favoriteTapped))
    }()
    
    
    // MARK: - View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.getUser()
    }
    
    // MARK: - Setup View
    private func setupView() {
        view.backgroundColor = UIColor.systemBackground
        navigationItem.rightBarButtonItem = favoriteItem
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    // MARK: - Action
    @objc
    func favoriteTapped() {
        interactor?.favoriteModify()
    }
    
}

// MARK: - Start of Extension Any

// MARK: - End of Extension Any
// MARK: - View Protocol
extension UserViewController: UserDisplayLogic {
    
    func displayUser(user: UserModel.User) {
        userImageView.kf.setImage(with: user.avatar) { [unowned self] (result) in
            self.indicatorView.stopAnimating()
        }
        userLoginLabel.text = user.login
        userGithubLabel.text = user.githubUrl
        userAccountTypeLabel.text = user.accountType
        userSiteadminLabel.text = user.siteAdmin
        interactor?.user = user
        interactor?.updateFavorite(user: user)
    }
    
    func displayFavorite(image: UIImage) {
        favoriteItem.image = image
    }
    
    func showLoading() {
        let width = UIScreen.main.bounds.width
        let size = CGSize(width: width * 0.25 , height: width * 0.25)
        startAnimating(size, type: .circleStrokeSpin, fadeInAnimation: nil)
    }
    
    func hideLoading() {
        stopAnimating()
    }
}
