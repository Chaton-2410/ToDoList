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
    
    private let task: ListModel
    private let provider: TaskDetailDataProviderProtocol
    
    private lazy var contentView: TaskDetailDisplayView = {
        let view = TaskDetailView()
        view.delegate = self
        return view
    }()
    
    init(task: ListModel, provider: TaskDetailDataProviderProtocol) {
        self.task = task
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.configure(with: task)
        setupNavigation()
    }
}

// MARK: - TaskDetailViewDelegate
extension TaskDetailViewController: TaskDetailViewDelegate {
    func didCompleteTaskButtonTapped() {
        
        provider.updateTaskStatus(for: task)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TaskDetailViewControllerProtocol
extension TaskDetailViewController: TaskDetailViewControllerProtocol {
    func configure(with model: ListModel) {
        navigationItem.title = model.title
    }
}

// MARK: -  setupNavigation
private extension TaskDetailViewController {
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(didDeleteTaskButtonTapped)
            )
        
        navigationItem.rightBarButtonItem?.tintColor = .specialButtonColor
    }
    
    @objc
    private func didDeleteTaskButtonTapped(sender: UIButton) {
        provider.deletaTask(for: task)
        navigationController?.popViewController(animated: true)
    }
}
