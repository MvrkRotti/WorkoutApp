//
//  BaseTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

final class BaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame : frame)
        
        setupConstraints()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension BaseTextField {
    func setupConstraints() {}
    func setupAppearance() {}
}
