//
//  DifficultyLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 01.03.2024.
//

import UIKit

final class DifficultyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DifficultyLabel {
    func setupAppearence() {
        textColor = ColorResources.white
        textAlignment = .left
        font = FontResources.cellNameLabelFont
        text = "Error"
    }
}
