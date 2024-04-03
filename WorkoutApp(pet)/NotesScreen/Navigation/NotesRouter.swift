//
//  NotesRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

final class NotesRouter {
    
   weak var notesViewController: NotesScreenViewController?

    func pushNextScreen() {
        notesViewController?.navigationController?.pushViewController(AddNoteAssembler.buildModule(), animated: true)
    }
}
