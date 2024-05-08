//
//  EditProfileScreenRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit

final class EditProfileScreenRouter {
    
//    weak var editProfileViewController: EditProfileViewController?
//
//    func navigateBack() {
//        editProfileViewController?.navigationController?.popViewController(animated: true)
//    }
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}


