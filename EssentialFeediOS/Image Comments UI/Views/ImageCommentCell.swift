//
//  ImageCommentCell.swift
//  EssentialFeediOS
//
//  Created by Каспи on 19.08.2023.
//

import UIKit

public final class ImageCommentCell: UITableViewCell {
    
    private(set) public var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        return label
    }()
    
    private(set) public var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    
    private(set) public var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [usernameLabel, dateLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 12
        sv.distribution = .fill
        return sv
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        contentView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            messageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            messageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
