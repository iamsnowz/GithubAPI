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
    func displayNetworkError(alert: UIAlertController)
    func backToPrevious()
    func showLoading()
    func hideLoading()
}

public class UserViewController: UIViewController, NVActivityIndicatorViewable {
    
    // MARK: - IBOutlet Properties
    @IBOutlet var stackView: UIStackView!
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
    init() {
        super.init(nibName: "UserViewController", bundle: Bundle(for: type(of: self)))
        let interactor = UserInteractor(userWorker: UserWorker())
        let presenter = UserPresenter()
        let router = UserRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.getUser()
    }
    
    // MARK: - Setup View
    private func setupView() {
        stackView.isHidden = true
        indicatorView.isHidden = true
        view.backgroundColor = UIColor.systemBackground
        navigationItem.rightBarButtonItem = favoriteItem
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
        userLoginLabel.numberOfLines = 0
        userGithubLabel.numberOfLines = 0
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
        stackView.isHidden = false
        indicatorView.isHidden = false
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
    
    func displayNetworkError(alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func backToPrevious() {
        navigationController?.popViewController(animated: true)
    }
    
}
