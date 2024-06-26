//
//  AddExerciseCustomTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

final class AddExerciseCustomTextField: UITextField {
    
    enum AddNoteTextFieldType {
        case numberOfSets
        case numberOfReps
        case restTime
    }
    
    private let addNoteTextFieldType: AddNoteTextFieldType
    
    init(fieldType: AddNoteTextFieldType) {
        self.addNoteTextFieldType = fieldType
        super.init(frame: .zero)
        
        setupLayout()
        setupAppearance()
        
        switch fieldType {
        case .numberOfSets:
            placeholder = Const.numberOfSets
        case .numberOfReps:
            placeholder = Const.numberOfReps
        case .restTime:
            placeholder = Const.restTime
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddExerciseCustomTextField {
    func setupAppearance() {
        backgroundColor = ColorResources.black
        layer.cornerRadius = 15
        textColor = ColorResources.white
        alpha = 0.95
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        leftViewMode = .always
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            self.widthAnchor.constraint(equalToConstant: 260)
        ])
    }
}

