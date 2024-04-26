//
//  ListTableViewCell.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 25.03.2024.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let padding: CGFloat = 8
        static let descriptionLabelFontSize: CGFloat = 15
        static let heightLabel: CGFloat = 20
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants
            .descriptionLabelFontSize)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - configure with model
extension ListTableViewCell {
    func configure(with model: ListModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}

// MARK: - private extension
private extension ListTableViewCell {
    
    private func addSubviews() {
        [titleLabel,
         descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setConstaints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor
                .constraint(equalTo: topAnchor, constant: Constants.padding),
            titleLabel.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: Constants.padding),
            titleLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.heightLabel)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor
                .constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding),
            descriptionLabel.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: Constants.padding),
            descriptionLabel.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            descriptionLabel.bottomAnchor
                .constraint(equalTo: bottomAnchor, constant: -Constants.padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: Constants.heightLabel)
        ])
    }
}
