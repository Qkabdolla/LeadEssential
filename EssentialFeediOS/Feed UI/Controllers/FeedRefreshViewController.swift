//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Kabdolla on 23.04.2023.
//

import UIKit
import EssentialFeed

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView, FeedErrorView {
    private(set) lazy var view = loadView()
    private(set) var errorView = ErrorView()
    
    private let delegate: FeedRefreshViewControllerDelegate

    init(delegate: FeedRefreshViewControllerDelegate) {
        self.delegate = delegate
    }

    @objc func refresh() {
        delegate.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    func display(_ viewModel: FeedErrorViewModel) {
        errorView.message = viewModel.message
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
    
    deinit {
        print("FeedRefreshViewController")
    }
}
