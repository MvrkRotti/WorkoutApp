//
//  AuthorisationAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

struct AuthorisationAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = AuthorisationViewController()
        let router = AutoristaionRouter()
        
        viewController.router = router
        router.authotisationViewController = viewController
        
        return viewController
    }
}
