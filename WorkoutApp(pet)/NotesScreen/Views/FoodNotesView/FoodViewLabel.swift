//
//  FoodViewLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 12.03.2024.
//

import UIKit

final class FoodViewLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension FoodViewLabel {
    func setupAppearence() {
        text = "Food Notes"
        font = Resources.CommonFonts.cellNameLabelFont
        textAlignment = .left
    }
}
