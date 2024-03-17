//
//  TrainSegmentedController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 17.03.2024.
//

import UIKit

final class TrainSegmentedController: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupAppearence()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TrainSegmentedController {
    func setupAppearence() {
        selectedSegmentIndex = 0
        backgroundColor = Resources.CommonColors.black
        selectedSegmentTintColor = Resources.CommonColors.white
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Resources.CommonColors.white], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Resources.CommonColors.black], for: .selected)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
