//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Kabdolla on 23.04.2023.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    let locationContainer = UIView()
    let locationLabel = UILabel()
    let descriptionLabel = UILabel()
    let feedImageContainer = UIView()
    let feedImageView = UIImageView()
    
    private(set) public lazy var feedImageRetryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var onRetry: (() -> Void)?
    var onReuse: (() -> Void)?
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()

        onReuse?()
    }
}
