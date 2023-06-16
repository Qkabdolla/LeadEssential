//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Каспи on 16.06.2023.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
