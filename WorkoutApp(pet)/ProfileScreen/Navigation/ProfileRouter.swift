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
    func popToRoot()
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
    
    func popToRoot() {
        do {
            try Auth.auth().signOut()
            if let navigationController = viewController?.navigationController {
            navigationController.popToRootViewController(animated: true)
            }
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
