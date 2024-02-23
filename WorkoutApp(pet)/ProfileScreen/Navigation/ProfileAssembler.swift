//
//  ProfileAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

struct ProfileAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = ProfileScreenViewController()
        let router = ProfileRouter()
        
        viewController.router = router
        router.profileController = viewController
        
        return viewController
    }
}
