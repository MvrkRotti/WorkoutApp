//
//  NotesAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

struct NotesAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = NotesScreenViewController()
        let router = NotesRouter()
        
        viewController.router = router
        router.notesViewController = viewController
        
        return viewController
    }
}

