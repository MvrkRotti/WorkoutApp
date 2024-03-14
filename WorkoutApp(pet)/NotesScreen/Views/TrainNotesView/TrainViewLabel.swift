//
//  TrainViewLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.03.2024.
//

import UIKit

final class TrainViewLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension TrainViewLabel {
    func setupAppearence() {
        text = "Training Notes"
        font = Resources.CommonFonts.cellNameLabelFont
        textAlignment = .left
    }
}
