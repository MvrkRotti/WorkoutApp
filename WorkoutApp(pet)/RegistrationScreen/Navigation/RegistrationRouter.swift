//
//  RegistrationRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

final class RegistrationRouter {
    
    weak var registrationViewController: RegistrationViewController?

    func pushHomeScreen() {
        registrationViewController?.navigationController?.pushViewController(HomeScreenViewController(), animated: true)
    }
}
