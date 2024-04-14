//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {
    func didSaveButtonTapped()
}

protocol AddTaskDisplayView: UIView {
    func setupPickerData(with model: [AddTaskPickerData])
}

final class AddTaskView: UIView {
    
    private enum Constants {
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let textFieldHeight: CGFloat = 48
    }
    
    weak var delegate: AddTaskViewDelegate?
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter task title"
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: view.frame.height))
        view.leftViewMode = .always
        return view
    }()
    
    private lazy var desriptionTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Enter task desription"
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: view.frame.height))
        view.leftViewMode = .always
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .specialButtonColor
        view.setTitle("Save", for: .normal)
        view.titleLabel?.textColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.addTarget(
            self,
            action: #selector(didSaveButtonTapped),
            for: .touchUpInside
        )
        return view
    }()
    
    private lazy var picker: UIPickerView = {
        let view = UIPickerView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.delegate = pickerManager
        view.dataSource = pickerManager
        return view
    }()
    
    private let pickerManager = AddTaskPickerManager()
    private lazy var datePicker = UIDatePicker()
    
    init() {
        super.init(frame: .zero)
        addSubiews()
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - AddTaskDisplayView
extension AddTaskView: AddTaskDisplayView {
    func setupPickerData(with model: [AddTaskPickerData]) {
        pickerManager.dataPicker = model
    }
}

// MARK: - private extension
private extension AddTaskView {
    
    @objc
    private func didSaveButtonTapped(sender: UIButton) {
        delegate?.didSaveButtonTapped()
    }
    
    private func addSubiews() {
        [
            titleTextField,
            desriptionTextField,
            picker,
            datePicker,
            saveButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupViews() {
        backgroundColor = .systemGroupedBackground
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            titleTextField.bottomAnchor.constraint(equalTo: desriptionTextField.topAnchor, constant: -Constants.padding),
            titleTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            desriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Constants.padding),
            desriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            desriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            desriptionTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            desriptionTextField.bottomAnchor.constraint(equalTo: picker.topAnchor, constant: -Constants.padding)
        ])
        
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: desriptionTextField.bottomAnchor, constant: Constants.padding),
            picker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            picker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            picker.bottomAnchor.constraint(equalTo: datePicker.topAnchor, constant: -Constants.padding)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: Constants.padding),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }
}

