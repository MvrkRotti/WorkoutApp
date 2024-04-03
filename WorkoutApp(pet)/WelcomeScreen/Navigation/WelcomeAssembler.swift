//
//  WelcomeAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

struct WelcomeAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = WelcomeViewController()
        let router = WelcomeRouter()
        
        viewController.router = router
        router.welcomeViewController = viewController
        
        return viewController
    }
}
