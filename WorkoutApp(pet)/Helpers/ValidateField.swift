//
//  ValidateField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 13.05.2024.
//

import Foundation
import UIKit


final class ValidateField {
    static func voidValidateFields(textFields: [UITextField]) -> Bool {
        var isValid = true
        
        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
                isValid = false
            } else {
                textField.layer.borderColor = nil
                textField.layer.borderWidth = 0.0
            }
        }
        return isValid
    }
}
