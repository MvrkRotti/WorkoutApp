//
//  NotesRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

protocol Assembler: AnyObject {
    func resolve() -> WelcomeViewController
    func resolve() -> AuthorisationViewController
    func resolve() -> RegistrationViewController
    func resolve() -> HandbookScreenViewController
    func resolve() -> NotesScreenViewController
    func resolve() -> AddNoteViewController
    func resolve() -> ProfileScreenViewController
}

class DefaultAssembler: Assembler {
    
    func resolve() -> WelcomeViewController {
        let router = DefaultRouter(assembler: self)
        let viewController = WelcomeViewController(router: router)
        return viewController
    }

    func resolve() -> AuthorisationViewController {
        let viewModel = AuthorisationViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = AuthorisationViewController(router: router, viewModel: viewModel)
        return viewController
    }

    func resolve() -> RegistrationViewController {
        let router = DefaultRouter(assembler: self)
        let viewModel = RegistrationViewModel()
        let viewController = RegistrationViewController(router: router, viewModel: viewModel)
        return viewController
    }

    func resolve() -> HandbookScreenViewController {
        let viewModel = HandbookViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = HandbookScreenViewController(viewModel: viewModel, router: router)
        return viewController
    }

    func resolve() -> NotesScreenViewController {
        let viewModel = NotesViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = NotesScreenViewController(router: router, viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
    
    func resolve() -> AddNoteViewController {
            let viewModel = NotesViewModel()
            let viewController = AddNoteViewController(viewModel: viewModel)
            return viewController
        }
    func resolve() -> ProfileScreenViewController {
        let viewModel = ProfileViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = ProfileScreenViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
