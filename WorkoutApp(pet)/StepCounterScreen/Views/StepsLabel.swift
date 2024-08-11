//
//  StepsLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit

final class StepsLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        font = FontResources.boldSystemFont40
        textColor = ColorResources.customBlue
        textAlignment = .center
    }
}
