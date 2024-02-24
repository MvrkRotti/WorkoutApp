//
//  HeightTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit

final class HeightTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HeightTextField {
    func setupAppearence() {
        layer.cornerRadius = 10
        placeholder = Resources.TextField.PlaceholderString.height
        layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textColor = Resources.CommonColors.white
        backgroundColor = Resources.CommonColors.black
    }
}
