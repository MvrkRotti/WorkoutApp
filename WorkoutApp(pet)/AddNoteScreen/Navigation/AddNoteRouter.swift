//
//  AddNoteRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

final class AddNoteRouter {
    
    weak var addNoteViewController: AddNoteViewController?

    func pushNextScreen() {
        addNoteViewController?.navigationController?.present(AddExerciseAssembler.buildModule(), animated: true)
    }
}
