//
//  TabAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

struct TabAssembler {
    
    static func buildModule() -> UIViewController {
        
        let viewController = TabController()
        let router = TabRouter()
        
        viewController.router = router
        router.tabController = viewController
        
        return viewController
    }
}
