//
//  CustomNavBarButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 27.06.2024.
//

import UIKit

enum barButtonType {
    case logOut
    case edit
    case back
}

final class CustomNavBarButton: UIButton {
    init(type: barButtonType) {
        super.init(frame: .zero)
        configureButtonWith(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButtonWith(_ type: barButtonType) {

        switch type {
        case .logOut:
            setTitleColor(ColorResources.customRed, for: .normal)
        case .edit:
            backgroundColor = ColorResources.customBlue
            tintColor = ColorResources.white
            layer.cornerRadius = 15
            clipsToBounds = true
        case .back:
            backgroundColor = ColorResources.customBlue
            tintColor = ColorResources.white
            layer.cornerRadius = 15
            clipsToBounds = true
        }
    }
}
