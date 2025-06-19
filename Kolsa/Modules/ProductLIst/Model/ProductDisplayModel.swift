//
//  ProductDisplayModel.swift
//  KolsaTest
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import UIKit
import Foundation

struct ProductDisplayModel: Hashable {
    let name: String
    let description: String
    let formattedPrice: NSAttributedString
    
    init(product: Product) {
        self.name = product.name
        self.description = product.description
        let priceString = String(format: "%.2f", product.price)
        let fullString = "\(priceString) ₽"
        let attributedString = NSMutableAttributedString(string: fullString, attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
        attributedString.addAttributes([.foregroundColor: UIColor.label], range: (fullString as NSString).range(of: priceString))
        attributedString.addAttributes([.foregroundColor: UIColor.gray], range: (fullString as NSString).range(of: " ₽"))
        self.formattedPrice = attributedString
    }
} 
