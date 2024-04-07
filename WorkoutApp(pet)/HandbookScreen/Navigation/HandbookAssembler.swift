//
//  HomeAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//


import UIKit

struct HandbookAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = HandbookScreenViewController()
//        let router = HomeRouter()
//        
//        viewController.router = router
//        router.homeViewController = viewController
        
        return viewController
    }
}
