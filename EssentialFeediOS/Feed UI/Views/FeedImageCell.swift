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
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessibilityIdentifier = "feed-image-cell"
        feedImageView.accessibilityIdentifier = "feed-image-view"
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        onReuse?()
    }
    
    private func setupUI() {
        addSubview(feedImageView)
        feedImageView.translatesAutoresizingMaskIntoConstraints = false
        feedImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            feedImageView.topAnchor.constraint(equalTo: topAnchor),
            feedImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            feedImageView.leftAnchor.constraint(equalTo: leftAnchor),
            feedImageView.rightAnchor.constraint(equalTo: rightAnchor),
            feedImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
    }
}
