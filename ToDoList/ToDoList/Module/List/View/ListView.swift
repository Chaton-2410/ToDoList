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

protocol ListViewDelegate: AnyObject {
    func searchBar(textDidChange searchText: String)
    
    func didSelectRow(_ model: ListModel)
}

final class ListView: UIView {
    
    private enum Constants {
        static let padding: CGFloat = 16
        static let startLabelFontSize: CGFloat = 18
        static let searchBarPlaceholder: String = "Enter task name"
        static let startLabelText: String = "You haven't add a  tasks yet..."
    }
    
    private lazy var listManager: ListTableManager = ListTableManager()
    private lazy var searchManager: ListSearchManager = ListSearchManager()
    weak var delegate: ListViewDelegate?
    
    private lazy var startLabel: UILabel = {
        let view = UILabel()
        view.text = Constants.startLabelText
        view.textColor = .black
        view.textAlignment = .center
        view.font = .systemFont(ofSize: Constants.startLabelFontSize)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var  tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.dataSource = listManager
        view.delegate = listManager
        view.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.delegate = searchManager
        view.placeholder = Constants.searchBarPlaceholder
        view.searchBarStyle = .minimal
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

// MARK: - DisplayListView
extension ListView: DisplayListView {
    func confuge(with model: [ListModel]) {
        listManager.tableData = model
        startLabel.isHidden = model.count != 0
        tableView.reloadData()
    }
}

// MARK: - ListSearchManagerDelegate
extension ListView: ListSearchManagerDelegate {
    func searchBar(textDidChange searchText: String) {
        delegate?.searchBar(textDidChange: searchText)
    }
}

// MARK: - ListTableManagerDelegate
extension ListView: ListTableManagerDelegate {
    func didSelectRow(_ model: ListModel) {
        delegate?.didSelectRow(model)
    }
}

// MARK: - private extension
private extension ListView {
    
    private func addSubviews() {
        tableView.addSubview(startLabel)
        
        [tableView, 
         searchBar].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupViews() {
        backgroundColor = .systemGroupedBackground
        searchManager.delegate = self
        listManager.delegate = self
    }
    
    private func setConstaints() {
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .zero),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
        ])
        
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: Constants.padding),
            startLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: .zero),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: .zero)
        ])
    }
}
