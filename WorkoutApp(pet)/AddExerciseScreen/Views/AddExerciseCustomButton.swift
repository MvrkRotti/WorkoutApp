//
//  AddExerciseCustomButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

final class AddExerciseCustomButton: UIButton {
    
    var cancelButtonTapped: (() -> Void)?
    var saveButtonTapped: (() -> Void)?
    
    
    enum AddExerciseButtonType {
        case save
        case cancel
    }
    
    private let addExerciseButtonType: AddExerciseButtonType
    
    init(buttonType: AddExerciseButtonType) {
        self.addExerciseButtonType = buttonType
        super.init(frame: .zero)
        
        setupAppearance()
        setupLayout()
        
        switch buttonType {
        case .save:
            addTarget(self, action: #selector(saveDidTapped), for: .touchUpInside)
            backgroundColor = ColorResources.customCoral
            setTitle(Const.save, for: .normal)
        case .cancel:
            addTarget(self, action: #selector(cancelDidTapped), for: .touchUpInside)
            backgroundColor = ColorResources.white
            setTitle(Const.cancel, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddExerciseCustomButton {
    func setupAppearance() {
        layer.cornerRadius = 15
        setTitleColor(ColorResources.black, for: .normal)
        titleLabel?.textAlignment = .center
        makeSystem(self)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            self.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    @objc func cancelDidTapped() {
        cancelButtonTapped?()
    }
    
    @objc func saveDidTapped() {
        saveButtonTapped?()
    }
}

