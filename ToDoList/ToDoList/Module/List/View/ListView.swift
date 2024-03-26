//
//  ListView.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 24.03.2024.
//

import UIKit

protocol DisplayListView: UIView {
    func confuge(with model: [ListModel])
}

final class ListView: UIView {
    
    private lazy var listManager: ListTableManager = ListTableManager()
    
    private lazy var  tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.dataSource = listManager
        view.delegate = listManager
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupViews()
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: - DisplayListView
extension ListView: DisplayListView {
    func confuge(with model: [ListModel]) {
        listManager.tableData = model
        tableView.reloadData()
    }
}

extension ListView {
    
    private func addSubviews() {
        [tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
    }
    
    private func setConstaints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .zero),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: .zero)
        ])
    }
}
