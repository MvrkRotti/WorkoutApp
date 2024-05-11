//
//  ProfileRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit
import FirebaseAuth

protocol ProfileRouterProtocol: AnyObject {
    func pushEditScreen()
    func popToRoot(form viewController: UIViewController)
}

final class ProfileRouter: ProfileRouterProtocol {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushEditScreen() {
        let editScreen = EditProfileScreenAssembler.buildModule()
        viewController?.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    func popToRoot(form viewController: UIViewController) {
        
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Ошибка выхода из Firebase: \(signOutError.localizedDescription)")
            return
        }
        
        if let tabBarController = viewController.tabBarController,
           let navigationController = tabBarController.navigationController {
            for viewController in navigationController.viewControllers {
                if viewController is WelcomeViewController {
                    navigationController.popToViewController(viewController, animated: true)
                    return
                }
            }
        }
    }
}


