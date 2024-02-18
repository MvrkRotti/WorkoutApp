//
//  HomeAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//


import UIKit

struct HomeAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = HomeScreenViewController()
        let router = HomeRouter()
        
        viewController.router = router
        router.homeViewController = viewController
        
        return viewController
    }
}
