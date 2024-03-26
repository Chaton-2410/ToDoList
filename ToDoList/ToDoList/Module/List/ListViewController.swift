//
//  ListViewController.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 24.03.2024.
//

import UIKit

final class ListViewController: UIViewController {
    
    private lazy var contentView: DisplayListView = {
        let view = ListView()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        contentView.confuge(with: ListModelGenerator.getData())
    }
}

//MARK: - setupNavigation
extension ListViewController {
    
    private func setupNavigation() {
        navigationItem.title = "ToDoList"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
