//
//  ProductListViewController.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import Combine
import UIKit

// MARK: - ProductListViewController
final class ProductListViewController: UIViewController {
    
    private enum ProductListSection {
        case main
    }

    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        tableView.register(SortInfoCell.self, forCellReuseIdentifier: SortInfoCell.reuseId)
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // MARK: - Private properties
    
    private let viewModel: ProductListViewModelProtocol
    private var dataSource: UITableViewDiffableDataSource<ProductListSection, ListItem>!
    private var cancellables = Set<AnyCancellable>()
    private var currentState: ProductListViewModel.State?

    // MARK: - Initializers
    
    init(viewModel: ProductListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        bindViewModel()
        Task { await viewModel.loadProducts() }
    }

    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        title = "Товары"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<ProductListSection, ListItem>(tableView: tableView) { [weak self] (tableView, indexPath, item) in
            switch item {
            case .sortButton:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SortInfoCell.reuseId, for: indexPath) as? SortInfoCell else { return nil }
                cell.configure(with: self?.currentState?.sortButtonTitle ?? "")
                return cell
                
            case .product(let product):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as? ProductCell else { return nil }
                cell.configure(with: product)
                return cell
            }
        }
        dataSource.defaultRowAnimation = .fade
    }
    
    private func bindViewModel() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.currentState = state
                self?.render(state: state)
            }
            .store(in: &cancellables)
    }
    
    private func render(state: ProductListViewModel.State) {
        switch state.content {
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
            errorLabel.isHidden = true
            
        case .failure(let errorText):
            activityIndicator.stopAnimating()
            tableView.isHidden = true
            errorLabel.isHidden = false
            errorLabel.text = errorText
            
        case .success(let items):
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            errorLabel.isHidden = true
            applySnapshot(with: items)
        }
    }

    private func applySnapshot(with items: [ListItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<ProductListSection, ListItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        if snapshot.itemIdentifiers.contains(.sortButton) {
            snapshot.reconfigureItems([.sortButton])
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UITableViewDelegate
extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        switch item {
        case .sortButton:
            viewModel.toggleSortOrder()
            
        case .product(let product):
            let detailVC = ProductDetailViewController(displayModel: product)
            present(detailVC, animated: true)
        }
    }
}
