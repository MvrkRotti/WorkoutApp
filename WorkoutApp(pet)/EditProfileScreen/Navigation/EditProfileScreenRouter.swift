//
//  EditProfileScreenRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit
import FirebaseAuth

final class EditProfileScreenRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}


