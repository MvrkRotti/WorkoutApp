//
//  AddExerciseButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

final class AddExerciseButton: UIButton {
    
    var addExerciseButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupLayout()
        setupAction()
        makeSystem(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddExerciseButton {
    func setupAppearance() {
        setTitle(Const.addNewExercise, for: .normal)
        setTitleColor(ColorResources.black, for: .normal)
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 15
        backgroundColor = ColorResources.customCoral
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            widthAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    @objc
    func AddExerciseButtonDidTapped() {
        addExerciseButtonTapped?()
        
    }
    
    func setupAction() {
        addTarget(self, action: #selector(AddExerciseButtonDidTapped), for: .touchUpInside)
    }
}
