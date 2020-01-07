//
//  UIRefreshControl+Extension.swift
//  GithubAPI
//
//  Created by iAmSnow on 7/1/2563 BE.
//  Copyright © 2563 iAmSnow. All rights reserved.
//

import UIKit
extension UIRefreshControl {
    func endRefreshingWhenReloadData() {
        perform(#selector(endRefreshing), with: nil, afterDelay: 0.0)
    }
}

