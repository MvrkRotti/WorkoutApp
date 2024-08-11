//
//  GoalLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit

final class GoalLabel: BaseLabel {
    override func setupAppearrence() {
        translatesAutoresizingMaskIntoConstraints = false
        font = FontResources.systemFont18
        textColor = ColorResources.black
        textAlignment = .center
        text = "Test"
    }
}
