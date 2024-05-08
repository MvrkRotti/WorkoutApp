//
//  EditProfileScreenAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit

struct EditProfileScreenAssembler {
    
    static func buildModule() -> UIViewController {
        
        let user = User()
        let viewModel = EditProfileViewModel(user: user)
        let viewController = EditProfileViewController(viewModel: viewModel)
        let router = EditProfileScreenRouter(viewController: viewController)
        
        viewController.router = router
        viewController.viewModel = viewModel
        
        return viewController
    }
}

