//
//  AddNoteAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

struct AddNoteAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = AddNoteViewController()
        let router = AddNoteRouter()
        
        viewController.router = router
        router.addNoteViewController = viewController
        
        return viewController
    }
}
