//
//  EditProfileCustomTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 30.09.2024.
//

import Foundation
import UIKit

enum EditTextFieldType {
    case age
    case weight
    case height
}

final class EditProfileCustomTextField: UITextField {
    init(type: EditTextFieldType) {
        super.init(frame: .zero)
        configureTextFieldWith(type: type)
        addCustomBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let bottomBorder = self.layer.sublayers?.first(where: { $0.borderColor == UIColor.black.cgColor }) {
            bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - bottomBorder.borderWidth, width: self.frame.size.width, height: bottomBorder.borderWidth)
        }
    }
}

private extension EditProfileCustomTextField {
    func configureTextFieldWith(type: EditTextFieldType) {
        switch type {
        case .age:
            placeholder = Const.age
        case .weight:
            placeholder = Const.weight
        case .height:
            placeholder = Const.height
        }
        textColor = ColorResources.black
    }
    
    func addCustomBorder() {
        let bottomBorder = CALayer()
        let borderWidth = CGFloat(1.0)
        bottomBorder.borderColor = UIColor.black.cgColor
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: borderWidth)
        bottomBorder.borderWidth = borderWidth
        self.layer.addSublayer(bottomBorder)
        self.layer.masksToBounds = true
    }
}
