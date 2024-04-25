//
//  ListViewController.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 24.03.2024.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var tasks: [ListModel] = []
    private let provider: ListDataProviderProtocol
    
    private lazy var contentView: DisplayListView = {
        let view = ListView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    init(provider: ListDataProviderProtocol) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tasks = provider.fetchTasks()
        contentView.confuge(with: tasks)
    }
}

//MARK: - ListViewDelegate
extension ListViewController: ListViewDelegate {
    
    func searchBar(textDidChange searchText: String) {
        var filtered: [ListModel] = []
        
        guard !searchText.isEmpty else {
            contentView.confuge(with: tasks)
            return
        }
        
        for task in tasks {
            if task.title.lowercased().contains(searchText.lowercased()) {
                filtered.append(task)
            }
        }
        
        contentView.confuge(with: filtered)
    }
    
    func didSelectRow(_ model: ListModel) {
        let name: String = "ListCoreDataModel"
        let coreDatraManager: CoreDataManagerProtocol = CoreDataManager(persistentContainerName: name)
        let provider: TaskDetailDataProviderProtocol = TaskDetailDataProvider(coreDataManeger: coreDatraManager)
        
        let controller = TaskDetailViewController(task: model, provider: provider)
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
        let name: String = "ListCoreDataModel"
        let coreDatraManager: CoreDataManagerProtocol = CoreDataManager(persistentContainerName: name)
        let provider: AddTaskDataProviderProtocol = AddTaskDataProvider(coreDataManeger: coreDatraManager)
        let controller = AddTaskViewController(provider: provider)
        navigationController?.pushViewController(controller, animated: true)
    }
}
