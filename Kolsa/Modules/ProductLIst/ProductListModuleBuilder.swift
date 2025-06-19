//
//  ProductListModuleBuilder.swift
//  KolsaTest
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import UIKit

struct ProductListModuleBuilder {
    static func build(container: Container) -> UIViewController {
        ProductListViewController(
            viewModel: container.resolve(ProductListViewModelProtocol.self)
        )
    }
} 
