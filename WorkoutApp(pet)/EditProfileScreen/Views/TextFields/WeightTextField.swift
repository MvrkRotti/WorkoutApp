//
//  WeightTextField.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit

final class WeightTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeightTextField {
    func setupAppearence() {
        layer.cornerRadius = 15
        placeholder = Resources.TextField.PlaceholderString.weight
        layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        textColor = Resources.Colors.white
        backgroundColor = Resources.Colors.black
    }
}
