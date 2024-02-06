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
        welcomeViewController?.navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    func pushAutoristrationScreen() {
        welcomeViewController?.navigationController?.pushViewController(AuthorisationViewController(), animated: true)
    }
}
