//
//  AddExerciseAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

struct AddExerciseAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = AddExerciseViewController()
        let router = AddExerciseRouter()
        
        viewController.router = router
        router.addExerciseViewController = viewController
        
        return viewController
    }
}
