//
//  TrainingNameTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

final class AddNoteCustomTextField: UITextField {
    
    enum AddNoteTextFieldType {
        case trainingName
        case kindOfMuscle
        case exerciseName
    }
    
    private let addNoteTextFieldType: AddNoteTextFieldType
    
    init(fieldType: AddNoteTextFieldType) {
        self.addNoteTextFieldType = fieldType
        super.init(frame: .zero)
        
        setupLayout()
        setupAppearence()
        
        switch fieldType {
        case .trainingName:
            placeholder = Resources.TextField.PlaceholderString.trainingName
        case .kindOfMuscle:
            placeholder = Resources.TextField.PlaceholderString.muscle
        case .exerciseName:
            placeholder = Resources.TextField.PlaceholderString.exerciseName

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddNoteCustomTextField {
    func setupAppearence() {
        backgroundColor = Resources.CommonColors.black
        layer.cornerRadius = 15
        textColor = Resources.CommonColors.white
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
            self.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
}
