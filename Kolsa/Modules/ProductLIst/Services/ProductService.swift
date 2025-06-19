//
//  ProductService.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

final class ProductService: ProductServiceProtocol {
    
    enum ServiceError: Error {
        case fileNotFound(String)
        case dataDecodingFailed
    }
    
    func fetchProducts() async throws -> [Product] {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            throw ServiceError.fileNotFound("products.json")
        }
        
        let data = try Data(contentsOf: url)
        
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            throw ServiceError.dataDecodingFailed
        }
    }
}
