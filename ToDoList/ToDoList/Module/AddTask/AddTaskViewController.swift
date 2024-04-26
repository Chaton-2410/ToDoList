//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    private enum Constants {
        static let navigationTitle: String = "Add Task"
    }
    
    private let provider: AddTaskDataProviderProtocol
    
    private lazy var contentView: AddTaskDisplayView = {
        let view = AddTaskView()
        view.delegate = self
        return view
    }()
    
    init(provider: AddTaskDataProviderProtocol) {
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
        navigationItem.title = Constants.navigationTitle
        contentView.setupPickerData(with: AddTaskPickerData.allCases)
    }
}

// MARK: - AddTaskViewDelegate
extension AddTaskViewController: AddTaskViewDelegate {
    func didSaveButtonTapped(with model: ListModel) {
        provider.createTask(with: model)
        navigationController?.popViewController(animated: true)
    }
}
