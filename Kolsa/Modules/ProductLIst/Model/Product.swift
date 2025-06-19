//
//  Product.swift
//  KolsaTest
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import Foundation

struct Product: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let price: Double

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
