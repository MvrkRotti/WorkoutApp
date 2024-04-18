//
//  ResetPasswordAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

struct ResetPasswordAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = ResetPasswordViewController()
        let router = ResetPasswordRouter()
        
        viewController.router = router
        router.resetPasswordViewController = viewController
        
        return viewController
    }
}
