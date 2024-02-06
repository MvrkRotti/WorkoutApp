//
//  AuthorisationAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

struct AuthorisationAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = AuthorisationViewController()
        let router = AuthorisationRouter()
        
        viewController.router = router
        router.authorisationViewController = viewController
        
        return viewController
    }
}
