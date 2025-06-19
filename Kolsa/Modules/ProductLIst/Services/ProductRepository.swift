//
//  ProductRepository.swift
//  KolsaTest
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts() async throws -> [Product]
}

final class ProductRepository: ProductRepositoryProtocol {
    
    private let productService: ProductServiceProtocol
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    func fetchProducts() async throws -> [Product] {
        try await productService.fetchProducts()
    }
}
