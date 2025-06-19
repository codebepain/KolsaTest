//
//  UIStackView.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addArrangedSubview(subview)
        }
    }
}
