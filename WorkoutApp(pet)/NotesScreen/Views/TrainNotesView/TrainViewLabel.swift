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
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

private extension TrainViewLabel {
    func setupAppearance() {
        text = "Training Notes"
        font = FontResources.cellNameLabelFont
        textAlignment = .left
    }
}
