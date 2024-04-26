//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {
    func didSaveButtonTapped(with model: ListModel)
}

protocol AddTaskDisplayView: UIView {
    func setupPickerData(with model: [AddTaskPickerData])
}

final class AddTaskView: UIView {
    
    private enum Constants {
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 10
        static let textFieldHeight: CGFloat = 48
        
        enum Text {
            static let titleTextFieldPlaceholder: String = "Enter task title"
            static let desriptionTextFieldPlaceholder: String = "Enter task desription"
            static let saveButtonTitle: String = "Save"
        }
        
        enum Animation {
            static let keyPath: String = "transform.scale"
            static let fromValue: CGFloat = 1
            static let toValue: CGFloat = 1.03
            static let duration: CFTimeInterval = 0.5
            static let damping: CGFloat = 1.5
            static let mass: CGFloat = 5
            static let animationKey: String = "saveButtonAnimation"
        }
    }
    
    weak var delegate: AddTaskViewDelegate?
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = Constants.Text.titleTextFieldPlaceholder
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: view.frame.height))
        view.leftViewMode = .always
        view.clearButtonMode = .always
        view.returnKeyType = .done
        view.delegate = self
        return view
    }()
    
    private lazy var desriptionTextField: UITextField = {
        let view = UITextField()
        view.placeholder = Constants.Text.desriptionTextFieldPlaceholder
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: view.frame.height))
        view.leftViewMode = .always
        view.clearButtonMode = .always
        view.returnKeyType = .done
        view.delegate = self
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .specialButtonColor
        view.setTitle(Constants.Text.saveButtonTitle, for: .normal)
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
    
    private let saveButtonAnimation: CASpringAnimation = {
        let animation = CASpringAnimation(keyPath: Constants.Animation.keyPath)
        animation.fromValue = Constants.Animation.fromValue
        animation.toValue = Constants.Animation.toValue
        animation.duration = Constants.Animation.duration
        animation.damping = Constants.Animation.damping
        animation.mass = Constants.Animation.mass
        animation.autoreverses = true
        return animation
    }()
    
    init() {
        super.init(frame: .zero)
        addSubiews()
        setupViews()
        setConstraints()
        addTaps()
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

// MARK: - UITextFieldDelegate
extension AddTaskView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        desriptionTextField.becomeFirstResponder()
    }
}

// MARK: - private extension
private extension AddTaskView {
    
    @objc
    private func didSaveButtonTapped(sender: UIButton) {
        let model = ListModel(
            id: UUID(),
            title: titleTextField.text ?? "",
            description: desriptionTextField.text ?? "",
            date: datePicker.date,
            category: pickerManager.dataPicker[picker.selectedRow(inComponent: 0)],
            isCompleted: false)
        delegate?.didSaveButtonTapped(with: model)
        saveButton.layer.add(saveButtonAnimation, forKey: Constants.Animation.animationKey)
    }
    
    /// скрытие клавиатуры при нажатии на любое место
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        addGestureRecognizer(tapScreen)
    }
    
    @objc
    private func hideKeyboard() {
        endEditing(true)
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

