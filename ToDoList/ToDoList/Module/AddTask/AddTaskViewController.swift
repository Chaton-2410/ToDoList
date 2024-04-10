//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    private lazy var contentView: AddTaskView = {
        let view = AddTaskView()
        view.delegate = self
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

// MARK: - AddTaskViewDelegate
extension AddTaskViewController: AddTaskViewDelegate {
    func didSaveButtonTapped() {
        print(#function)
    }
}
