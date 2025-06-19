//
//  ProductsAssembly.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import Foundation

final class ProductsAssembly: Assembly {
    
    func assemble(container: Container) {
        registerServices(container: container)
        registerViewModels(container: container)
    }
    
    private func registerServices(container: Container) {
        container.register(ProductServiceProtocol.self) { _ in
            ProductService()
        }
        
        container.register(ProductRepositoryProtocol.self) { resolver in
            ProductRepository(productService: resolver.resolve(ProductServiceProtocol.self))
        }
    }
    
    private func registerViewModels(container: Container) {
        container.register(ProductListViewModelProtocol.self) { resolver in
            ProductListViewModel(repository: resolver.resolve(ProductRepositoryProtocol.self))
        }
    }
}
