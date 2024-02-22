//
//  HeightLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class HeightLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HeightLabel {
    func setupAppearence() {
        textColor = Resources.Colors.black
        font = Resources.Fonts.profileLabelFont
        text = "Height: "
    }
}
