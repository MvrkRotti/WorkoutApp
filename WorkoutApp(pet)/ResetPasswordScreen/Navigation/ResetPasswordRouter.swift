//
//  ResetPasswordRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//


import UIKit

final class ResetPasswordRouter {
    
    weak var resetPasswordViewController: ResetPasswordViewController?
    
    func popScreen() {
        resetPasswordViewController?.navigationController?.popViewController(animated: true)
    }
}
