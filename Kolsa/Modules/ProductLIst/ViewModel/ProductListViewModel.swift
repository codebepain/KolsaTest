//
//  ProductListViewModel.swift
//  KolsaTest
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import Combine
import Foundation

enum ListItem: Hashable {
    case sortButton
    case product(ProductDisplayModel)
}

protocol ProductListViewModelProtocol {
    var statePublisher: AnyPublisher<ProductListViewModel.State, Never> { get }
    
    func loadProducts() async
    func toggleSortOrder()
}


final class ProductListViewModel: ProductListViewModelProtocol {
    
    // MARK: - State Management
    
    enum ContentState: Equatable {
        case loading
        case success(items: [ListItem])
        case failure(error: String)
    }
    
    enum SortOrder {
        case byPrice, byName
        
        var buttonTitle: String {
            switch self {
            case .byPrice: return "Сортировать по алфавиту"
            case .byName: return "Сортировать по цене"
            }
        }
    }
    
    struct State: Equatable {
        var sortOrder: SortOrder = .byPrice
        var content: ContentState = .loading
        
        var sortButtonTitle: String {
            sortOrder.buttonTitle
        }
    }
    
    // MARK: - Private properties
    
    @Published private var state: State
    private var products: [Product] = []
    private let repository: ProductRepositoryProtocol
    
    // MARK: - Public properties
    var statePublisher: AnyPublisher<State, Never> {
        $state.eraseToAnyPublisher()
    }
    
    // MARK: - Initialization
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
        self.state = State()
    }
    
    // MARK: - Public methods
    
    @MainActor
    func loadProducts() async {
        state.content = .loading
        
        do {
            products = try await repository.fetchProducts()
            updateState()
        } catch {
            state.content = .failure(error: "Не удалось загрузить данные")
        }
    }
    
    func toggleSortOrder() {
        guard case .success = state.content else { return }
        
        state.sortOrder = (state.sortOrder == .byPrice) ? .byName : .byPrice
        updateState()
    }
    
    // MARK: - Private Methods
    
    private func updateState() {
        let sortedProducts = products.sorted {
            switch state.sortOrder {
            case .byName:
                return $0.name < $1.name
                
            case .byPrice:
                if $0.price == $1.price { return $0.name < $1.name }
                return $0.price < $1.price
            }
        }
        
        let listItems: [ListItem] = [.sortButton] + sortedProducts.map { .product(.init(product: $0)) }
        state.content = .success(items: listItems)
    }
}
