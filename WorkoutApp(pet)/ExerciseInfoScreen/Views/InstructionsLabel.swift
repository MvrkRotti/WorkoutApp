//
//  InstrucnionsLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 01.03.2024.
//

import UIKit

final class InstructionsLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InstructionsLabel {
    func setupAppearance() {
        textColor = ColorResources.white
        textAlignment = .left
        font = FontResources.cellNameLabelFont
        text = "Error"
        contentMode = .scaleAspectFit
        numberOfLines = 0
    }
}
