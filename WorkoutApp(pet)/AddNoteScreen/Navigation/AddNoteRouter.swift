//
//  AddNoteRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

protocol RouterProtocol {
    func presentNextScreen(on viewContoller: UIViewController, delegate: AddExerciseDelegate)
}

final class AddNoteRouter: RouterProtocol {
    func presentNextScreen(on viewContoller: UIViewController, delegate: AddExerciseDelegate) {
        let addExerciseViewController = AddExerciseViewController()
        addExerciseViewController.delegate = delegate
        viewContoller.present(addExerciseViewController, animated: true, completion: nil)
    }
}
