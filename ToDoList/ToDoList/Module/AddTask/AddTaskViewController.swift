//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    private lazy var contentView: AddTaskDisplayView = {
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
        contentView.setupPickerData(with: AddTaskPickerData.allCases)
    }
}

// MARK: - AddTaskViewDelegate
extension AddTaskViewController: AddTaskViewDelegate {
    func didSaveButtonTapped() {
        print(#function)
    }
}
