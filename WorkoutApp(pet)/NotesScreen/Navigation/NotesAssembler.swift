//
//  NotesAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

struct NotesAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewModel = NotesViewModel()
        let viewController = NotesScreenViewController(viewModel, router: NotesRouter())
        
//        let viewController = NotesScreenViewController()
//        let router = NotesRouter()
//
//        viewController.router = router
//        router.notesViewController = viewController
        
        return viewController
    }
}

//struct NotesAssembler: AssemblerProtocol {
//    
//    func buildModule() -> UIViewController {
//        
//        let viewModel = AddNoteViewModel()
//        let viewController = AddNoteViewController(viewModel, router: AddNoteRouter())
//
//        
//        return viewController
//    }
//}
