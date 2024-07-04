//
//  NotesAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit
protocol Assembler {
    func buildModule() -> AddNoteViewController
}

class NotesAssembler: Assembler {
    
    func buildModule() -> AddNoteViewController {
        
        let viewModel = NotesViewModel()
        
//        let viewController = NotesScreenViewController()
//        let router = NotesRouter()
//
//        viewController.router = router
//        router.notesViewController = viewController
        
        return AddNoteViewController(viewModel: viewModel)
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
