//
//  TaskDetailView.swift
//  ToDoList
//
//  Created by Valeriya Trofimova on 09.04.2024.
//

import UIKit

protocol TaskDetailDisplayView: UIView {
    func configure(with model: ListModel)
}

final class TaskDetailView: UIView {
    
    private lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .white
        return view
    }()
    
    private lazy var isCompletedLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        view.textColor = .white
        return view
    }()
    
    private lazy var categoryImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .specialButtonColor
        view.setTitle("Save", for: .normal)
        view.titleLabel?.textColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var saveButtonAnimation: CASpringAnimation = {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.03
        animation.duration = 0.5
        animation.damping = 1.5
        animation.mass = 5
        animation.autoreverses = true
        return animation
    }()
    
    private lazy var descrictionLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
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

// MARK: - TaskDetailDisplayView
extension TaskDetailView: TaskDetailDisplayView {
    func configure(with model: ListModel) {
    }
}

// MARK: - private extension
private extension TaskDetailView {
    private func addSubiews() {
        
    }
    
    private func setupViews() {
        backgroundColor = .systemGroupedBackground
    }
    
    private func setConstraints() {
        
    }
}

