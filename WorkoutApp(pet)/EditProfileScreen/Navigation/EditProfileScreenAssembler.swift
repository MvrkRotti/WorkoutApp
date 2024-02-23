//
//  EditProfileScreenAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit

struct EditProfileScreenAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = EditProfileViewController()
        let router = EditProfileScreenRouter()
        
        viewController.router = router
        router.editProfileViewController = viewController
        
        return viewController
    }
}
