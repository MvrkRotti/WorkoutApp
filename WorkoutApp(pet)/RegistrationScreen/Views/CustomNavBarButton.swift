//
//  CustomNavBarButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 27.06.2024.
//

import UIKit

final class CustomNavBarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearence() {
        backgroundColor = ColorResources.customBlue
        tintColor = ColorResources.white
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
