//
//  ProductCell.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupCell() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ])
    }
    
    func configure(with model: ProductDisplayModel) {
        nameLabel.text = model.name
        priceLabel.attributedText = model.formattedPrice
    }
}
