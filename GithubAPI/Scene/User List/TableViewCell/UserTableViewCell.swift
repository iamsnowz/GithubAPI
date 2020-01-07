//
//  UserTableViewCell.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    var userList: UserModel.UserList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard let list = userList?.users else { return }
        let user = list[sender.tag]
        UserFavoriteDatabase.shared.modify(user: user)
        updateFavoriteButton(user: user)
    }
    
    func updateUser(user: UserModel.User) {
        titleLabel.text = user.login
        updateFavoriteButton(user: user)
    }
    
    func updateIndex(tag: Int) {
        favoriteButton.tag = tag
    }
    
    func updateUserList(userList: UserModel.UserList) {
        self.userList = userList
    }
    
    private func updateFavoriteButton(user: UserModel.User) {
        let imageFavorite = UserFavoriteDatabase.shared.updateFavorite(user: user)
        favoriteButton.setImage(imageFavorite, for: .normal)
    }

}
