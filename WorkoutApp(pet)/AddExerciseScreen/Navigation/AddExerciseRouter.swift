//
//  AddExerciseRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

final class AddExerciseRouter {
    
    weak var addExerciseViewController: AddExerciseViewController?

    func popViewController() {
        addExerciseViewController?.navigationController?.popViewController(animated: true)
    }
}
