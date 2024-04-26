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

protocol TaskDetailViewDelegate: AnyObject {
    func didCompleteTaskButtonTapped()
}

final class TaskDetailView: UIView {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 15
        static let labelOfSize: CGFloat = 15
        static let descriptionLabelLinesLimit: Int = 30
        static let padding: CGFloat = 16
        static let paddingLabel: CGFloat = 8
        static let viewHeight: CGFloat = 50
        static let viewWidthMultiplier: CGFloat = 0.44
        
        enum Text {
            static let completeButtonTitle = "Complete task"
            static let statusLabelTextCompleted: String = "Completed"
            static let statusLabelTextProgress: String = "In progress"
            static let dateLabelText: String = "Date to complete: "
        }
        
        enum Animation {
            static let keyPath: String = "transform.scale"
            static let fromValue: CGFloat = 1
            static let toValue: CGFloat = 1.03
            static let duration: CFTimeInterval = 0.5
            static let damping: CGFloat = 1.5
            static let mass: CGFloat = 5
            static let animationKey: String = "completeButtonAnimation"
        }
    }
    
    private enum CategoryName {
        static let family: String = "figure.and.child.holdinghands"
        static let friends: String = "person.3.sequence.fill"
        static let study: String = "book.fill"
        static let work: String = "laptopcomputer"
        static let other: String = "archivebox.fill"
    }
    
    weak var delegate: TaskDetailViewDelegate?
    
  // MARK: - Backgrounds
    
    private lazy var categoryBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private lazy var statusBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private lazy var descriptionBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var dateBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Labels
    
    private lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.labelOfSize, weight: .medium)
        view.textColor = .white
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: Constants.labelOfSize, weight: .medium)
        view.textColor = .white
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = Constants.descriptionLabelLinesLimit
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    // MARK: - Image
    
    private lazy var categoryImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()
    
    // MARK: - Button
    
    private lazy var completeButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .specialButtonColor
        view.setTitle(Constants.Text.completeButtonTitle, for: .normal)
        view.titleLabel?.textColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        view.addTarget(self, action: #selector(completeTask), for: .touchUpInside)
        return view
    }()
    
    // MARK: - ButtonAnimation
    
    private lazy var completeButtonAnimation: CASpringAnimation = {
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc
    private func completeTask(sender: UIButton) {
        delegate?.didCompleteTaskButtonTapped()
        completeButton.layer.add(completeButtonAnimation, forKey: Constants.Animation.animationKey)
    }
}

// MARK: - TaskDetailDisplayView

extension TaskDetailView: TaskDetailDisplayView {
    func configure(with model: ListModel) {
        
        categoryLabel.text = model.category.rawValue
        statusLabel.text = model.isCompleted ? Constants.Text.statusLabelTextCompleted : Constants.Text.statusLabelTextProgress
        dateLabel.text = Constants.Text.dateLabelText + model.date.formatted(date: .abbreviated, time: .shortened)
        descriptionLabel.text = model.description
        
        statusBackground.backgroundColor = model.isCompleted ? .systemGreen : .systemRed
        
        completeButton.isHidden = model.isCompleted
        
        switch model.category {
        case .family:
            categoryImage.image = .init(systemName: CategoryName.family)
            categoryBackground.backgroundColor = .systemBlue
        case.friends:
            categoryBackground.backgroundColor = .systemGreen
            categoryImage.image = .init(systemName: CategoryName.friends)
        case .study:
            categoryImage.image = .init(systemName: CategoryName.study)
            categoryBackground.backgroundColor = .systemOrange
        case .work:
            categoryImage.image = .init(systemName: CategoryName.work)
            categoryBackground.backgroundColor = .systemMint
        case .other:
            categoryImage.image = .init(systemName: CategoryName.other)
            categoryBackground.backgroundColor = .systemYellow
        }
    }
}

// MARK: - private extension
private extension TaskDetailView {
    
    private func addSubiews() {
        [
            categoryBackground,
            statusBackground,
            descriptionBackground,
            dateBackground,
            categoryLabel,
            statusLabel,
            descriptionLabel,
            dateLabel,
            categoryImage,
            completeButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func setupViews() {
        backgroundColor = .systemGroupedBackground
    }
    
    private func setConstraints() {
        
        // MARK: - Category constraints
        
        NSLayoutConstraint.activate([
            categoryBackground.heightAnchor
                .constraint(equalToConstant: Constants.viewHeight),
            categoryBackground.widthAnchor
                .constraint(equalTo: widthAnchor, multiplier: Constants.viewWidthMultiplier),
            categoryBackground.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: Constants.padding),
            categoryBackground.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding)
        ])
        
        NSLayoutConstraint.activate([
            categoryImage.leadingAnchor
                .constraint(equalTo: categoryBackground.leadingAnchor, constant: Constants.paddingLabel),
            categoryImage.trailingAnchor
                .constraint(equalTo: categoryLabel.leadingAnchor, constant: -Constants.paddingLabel),
            categoryImage.centerYAnchor
                .constraint(equalTo: categoryBackground.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor
                .constraint(equalTo: categoryImage.trailingAnchor, constant: Constants.paddingLabel),
            categoryLabel.centerYAnchor
                .constraint(equalTo: categoryBackground.centerYAnchor)
        ])
        
        // MARK: - Status constraints
        
        NSLayoutConstraint.activate([
            statusBackground.heightAnchor
                .constraint(equalToConstant: Constants.viewHeight),
            statusBackground.widthAnchor
                .constraint(equalTo: widthAnchor, multiplier: Constants.viewWidthMultiplier),
            statusBackground.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            statusBackground.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor
                .constraint(equalTo: statusBackground.leadingAnchor, constant: Constants.paddingLabel),
            statusLabel.trailingAnchor
                .constraint(equalTo: statusBackground.trailingAnchor, constant: -Constants.paddingLabel),
            statusLabel.centerYAnchor
                .constraint(equalTo: categoryBackground.centerYAnchor)
        ])
        
        // MARK: - Description constraints
        
        NSLayoutConstraint.activate([
            descriptionBackground.topAnchor
                .constraint(equalTo: categoryBackground.bottomAnchor, constant: Constants.padding),
            descriptionBackground.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: Constants.padding),
            descriptionBackground.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            descriptionBackground.bottomAnchor
                .constraint(equalTo: dateBackground.topAnchor, constant: -Constants.padding)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor
                .constraint(equalTo: descriptionBackground.leadingAnchor, constant: Constants.paddingLabel),
            descriptionLabel.trailingAnchor
                .constraint(equalTo: descriptionBackground.trailingAnchor, constant: -Constants.paddingLabel),
            descriptionLabel.topAnchor
                .constraint(equalTo: descriptionBackground.topAnchor, constant: Constants.paddingLabel),
            descriptionLabel.bottomAnchor
                .constraint(equalTo: descriptionBackground.bottomAnchor, constant: -Constants.paddingLabel)
        ])
        
        // MARK: - Date constraints
        
        NSLayoutConstraint.activate([
            dateBackground.topAnchor
                .constraint(equalTo: descriptionBackground.bottomAnchor, constant: Constants.padding),
            dateBackground.leadingAnchor
                .constraint(equalTo: leadingAnchor, constant: Constants.padding),
            dateBackground.trailingAnchor
                .constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            dateBackground.heightAnchor
                .constraint(equalToConstant: Constants.viewHeight)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor
                .constraint(equalTo: dateBackground.leadingAnchor, constant: Constants.padding),
            dateLabel.trailingAnchor
                .constraint(equalTo: dateBackground.trailingAnchor, constant: -Constants.padding),
            dateLabel.centerYAnchor
                .constraint(equalTo: dateBackground.centerYAnchor)
        ])
        
        // MARK: - Button constraints
        
        NSLayoutConstraint.activate([
            completeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            completeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            completeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding),
            completeButton.heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        ])
    }
}

