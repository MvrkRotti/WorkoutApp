//
//  AddExerciseRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

final class AddExerciseRouter {
    
    weak var addExerciseViewController: AddExerciseViewController?

    func pushNextScreen() {
        addExerciseViewController?.navigationController?.pushViewController(TabAssembler.buildModule(), animated: true)
    }
}
