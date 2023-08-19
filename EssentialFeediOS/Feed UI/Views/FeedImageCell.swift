//
//  FeedImageCell.swift
//  EssentialFeediOS
//
//  Created by Kabdolla on 23.04.2023.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    lazy var locationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    lazy var feedImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var feedImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    private(set) public lazy var feedImageRetryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var onRetry: (() -> Void)?
    var onReuse: (() -> Void)?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        onReuse?()
    }
    
    private func setupUI() {
        contentView.addSubview(locationContainer)
        contentView.addSubview(feedImageContainer)
        contentView.addSubview(descriptionLabel)
        locationContainer.addSubview(locationLabel)
        feedImageContainer.addSubview(feedImageView)
        feedImageContainer.addSubview(feedImageRetryButton)
        
        NSLayoutConstraint.activate([
            locationContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            locationContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            locationContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            feedImageContainer.topAnchor.constraint(equalTo: locationContainer.bottomAnchor, constant: 10),
            feedImageContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            feedImageContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            feedImageContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: feedImageContainer.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: locationContainer.topAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationContainer.leftAnchor),
            locationLabel.rightAnchor.constraint(equalTo: locationContainer.rightAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: locationContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            feedImageView.topAnchor.constraint(equalTo: feedImageContainer.topAnchor),
            feedImageView.leftAnchor.constraint(equalTo: feedImageContainer.leftAnchor),
            feedImageView.rightAnchor.constraint(equalTo: feedImageContainer.rightAnchor),
            feedImageView.bottomAnchor.constraint(equalTo: feedImageContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            feedImageRetryButton.centerXAnchor.constraint(equalTo: feedImageContainer.centerXAnchor),
            feedImageRetryButton.centerYAnchor.constraint(equalTo: feedImageContainer.centerYAnchor)
        ])
    }
}
