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
        view.delegate = self
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

//MARK: - ListViewDelegate
extension ListViewController: ListViewDelegate {
    
    func searchBar(textDidChange searchText: String) {
        var filtered: [ListModel] = []
        
        if searchText.isEmpty {
            contentView.confuge(with: ListModelGenerator.getData())
        }
        
        for task in ListModelGenerator.getData() {
            if task.title.lowercased().contains(searchText.lowercased()) {
                filtered.append(task)
            }
        }
        
        contentView.confuge(with: filtered)
    }
    
    func didSelectRow(_ model: ListModel) {
        let controller = TaskDetailViewController()
        controller.configure(with: model)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - setupNavigation
extension ListViewController {
    
    private func setupNavigation() {
        navigationItem.title = "ToDoList"
        navigationController?.navigationBar.tintColor = .specialButtonColor
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addAddButtonTapped)
        )
    }
    
    @objc
    private func addAddButtonTapped(sender: UIButton) {
        let controller = AddTaskViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
