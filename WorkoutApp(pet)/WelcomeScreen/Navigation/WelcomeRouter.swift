//
//  WelcomeRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

final class WelcomeRouter {
    
    weak var welcomeViewController: WelcomeViewController?

    func pushRegistrationScreen() {
        welcomeViewController?.navigationController?.pushViewController(RegistrationAssembler.buildModule(), animated: true)
    }
    
    func pushAutoristrationScreen() {
        welcomeViewController?.navigationController?.pushViewController(AuthorisationAssembler.buildModule(), animated: true)
    }
}
