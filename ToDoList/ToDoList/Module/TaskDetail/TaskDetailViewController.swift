//
//  TaskDetailViewController.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

protocol TaskDetailViewControllerProtocol {
    func configure(with model: ListModel)
}

final class TaskDetailViewController: UIViewController {
    
    private lazy var contentView: TaskDetailDisplayView = {
        let view = TaskDetailView()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - TaskDetailViewControllerProtocol
extension TaskDetailViewController: TaskDetailViewControllerProtocol {
    func configure(with model: ListModel) {
        navigationItem.title = model.title
    }
}
