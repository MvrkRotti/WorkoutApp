//
//  WeightLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class WeightLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeightLabel {
    func setupAppearence() {
        textColor = ColorResources.black
        font = FontResources.profileLabelFont
        text = "Weight: "
    }
}
