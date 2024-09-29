//
//  SideBottomButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 29.09.2024.
//

import UIKit

enum SideButtonType {
    case bike
    case running
    case start
}

final class SideBottomButton: UIButton {
    init(type: SideButtonType) {
        super.init(frame: .zero)
        configureButtonWith(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
}

private extension SideBottomButton {
    func configureButtonWith(type: SideButtonType) {
        switch type {
        case .bike:
            setImage(UIImage(named: "bikeImage"), for: .normal)
            backgroundColor = .lightGray
            layer.borderWidth = 1
            layer.borderColor = ColorResources.customMainBlue.cgColor
            contentHorizontalAlignment = .center
        case .running:
            setImage(UIImage(named: "runningImage"), for: .normal)
            backgroundColor = .lightGray
            layer.borderWidth = 1
            layer.borderColor = ColorResources.customMainBlue.cgColor
            contentHorizontalAlignment = .center
        case .start:
            setTitle("Start", for: .normal)
            backgroundColor = ColorResources.customMainBlue

        }
        
    }
}
