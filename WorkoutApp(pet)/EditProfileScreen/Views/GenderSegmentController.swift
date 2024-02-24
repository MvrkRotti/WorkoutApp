//
//  GenderSegmentController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 24.02.2024.
//

import UIKit

final class GenderSegmentController: UISegmentedControl {
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupAppearence()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GenderSegmentController {
    func setupAppearence() {
        selectedSegmentIndex = 0
        backgroundColor = Resources.CommonColors.black
        selectedSegmentTintColor = Resources.CommonColors.white
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Resources.CommonColors.white], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Resources.CommonColors.black], for: .selected)
    }
}
