//
//  ProductDetailViewController.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import UIKit

final class ProductDetailViewController: UIViewController {

    // MARK: - UI
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Private properties
    
    private let displayModel: ProductDisplayModel
    
    // MARK: - Initializers
    
    init(displayModel: ProductDisplayModel) {
        self.displayModel = displayModel
        super.init(nibName: nil, bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemGroupedBackground
        setupUI()
        configureContent()
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubviews([nameLabel, priceLabel])
        stackView.setCustomSpacing(24, after: priceLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureContent() {
        nameLabel.text = displayModel.name
        descriptionLabel.text = displayModel.description
        priceLabel.attributedText = displayModel.formattedPrice
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ProductDetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        PopupPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
