//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Каспи on 19.08.2023.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
