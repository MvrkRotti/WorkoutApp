//
//  AddNoteAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

protocol AssemblerProtocol {
    func buildModule() -> UIViewController
}

struct AddNoteAssembler: AssemblerProtocol {
    
    func buildModule() -> UIViewController {
        
        let viewModel = AddNoteViewModel()
        let viewController = AddNoteViewController(viewModel, router: AddNoteRouter())

        
        return viewController
    }
}
