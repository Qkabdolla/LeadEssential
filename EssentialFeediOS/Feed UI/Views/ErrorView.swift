//
//  ErrorView.swift
//  EssentialFeediOS
//
//  Created by Каспи on 30.04.2023.
//

import UIKit

public final class ErrorView: UIView {
    
    private var label = UILabel()

    public var message: String? {
        get { return isVisible ? label.text : nil }
        set { setMessageAnimated(newValue) }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        label.text = nil
        alpha = 0
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = nil
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        label.text = nil
        alpha = 0
    }
    
    private var isVisible: Bool {
        return alpha > 0
    }

    private func setMessageAnimated(_ message: String?) {
        if let message = message {
            showAnimated(message)
        } else {
            hideMessageAnimated()
        }
    }

    private func showAnimated(_ message: String) {
        label.text = message

        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }

    private func hideMessageAnimated() {
        UIView.animate(
            withDuration: 0.25,
            animations: { self.alpha = 0 },
            completion: { completed in
                if completed { self.label.text = nil }
            })
    }
}
