//
//  ProfileAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

struct ProfileAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewModel = ProfileViewModel()
        let viewController = ProfileScreenViewController(viewModel: viewModel)
        let router = ProfileRouter(viewController: viewController)
        
        viewController.router = router
        viewController.viewModel = viewModel
        
        return viewController
    }
}

