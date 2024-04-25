//
//  NotesRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

protocol NotesRouterProtocol {
    func pushNextScreen(on viewContoller: UIViewController, delegate: AddNoteDelegate)
}

final class NotesRouter: NotesRouterProtocol {
    func pushNextScreen(on viewContoller: UIViewController, delegate: AddNoteDelegate) {
        let addNoteViewController = AddNoteViewController(AddNoteViewModel(), router: AddNoteRouter())
        addNoteViewController.delegate = delegate
        viewContoller.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}

