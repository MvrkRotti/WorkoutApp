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
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GenderSegmentController {
    func setupAppearance() {
        selectedSegmentIndex = 0
        backgroundColor = ColorResources.customGray
        selectedSegmentTintColor = ColorResources.customMainBlue
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorResources.black], for: .normal)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: ColorResources.white], for: .selected)
    }
}
