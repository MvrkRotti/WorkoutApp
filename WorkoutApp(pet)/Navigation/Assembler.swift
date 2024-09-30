//
//  NotesRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit
import Foundation

protocol Assembler: AnyObject {
    func resolve() -> WelcomeViewController
    func resolve() -> AuthorisationViewController
    func resolve() -> RegistrationViewController
    func resolve() -> StepCounterViewController
    func resolve() -> TrackingScreenViewController
    func resolve() -> NotesScreenViewController
    func resolve() -> AddNoteViewController
    func resolve(note: Note) -> NoteInfoViewController
    func resolve() -> ProfileScreenViewController
    func resolve() -> ResetPasswordViewController
    func resolve() -> EditProfileViewController
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
        let viewModel = RegistrationViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = RegistrationViewController(router: router, viewModel: viewModel)
        return viewController
    }
    
    func resolve() -> StepCounterViewController {
        let viewModel = StepViewModel(model: StepModel())
        let router = DefaultRouter(assembler: self)
        let viewController = StepCounterViewController(viewModel: viewModel, router: router)
        return viewController
    }
    
    func resolve() -> TrackingScreenViewController {
        let workoutService = WorkoutService()
        let viewModel = TrackingViewModel(sportType: .running, workoutService: workoutService)
        let router = DefaultRouter(assembler: self)
        let viewController = TrackingScreenViewController(viewModel: viewModel, router: router)
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
        viewModel.delegate = viewController as? any NotesViewModelDelegate
        return viewController
    }
    
    func resolve(note: Note) -> NoteInfoViewController {
        let viewController = NoteInfoViewController()
        viewController.note = note
        return viewController
    }
    
    func resolve() -> ProfileScreenViewController {
        let viewModel = ProfileViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = ProfileScreenViewController(viewModel: viewModel, router: router)
        return viewController
    }
    
    func resolve() -> ResetPasswordViewController {
        let viewModel = ResetPasswordViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = ResetPasswordViewController(router: router, viewModel: viewModel)
        return viewController
    }
    
    func resolve() -> EditProfileViewController {
        let viewModel = EditProfileViewModel()
        let router = DefaultRouter(assembler: self)
        let viewController = EditProfileViewController(viewModel: viewModel, router: router)
        return viewController
    }
}
