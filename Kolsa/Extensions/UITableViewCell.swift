//
//  UITableViewCell.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import UIKit

protocol ReuseIdentifiable: AnyObject {
    static var reuseId: String { get }
}

extension ReuseIdentifiable {
    static var reuseId: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
