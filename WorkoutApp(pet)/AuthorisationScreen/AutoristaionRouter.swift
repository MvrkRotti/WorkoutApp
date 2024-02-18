//
//  AutoristaionRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

final class AutoristaionRouter {
    
    weak var authotisationViewController: AuthorisationViewController?

    func pushHomeScreen() {
        authotisationViewController?.navigationController?.pushViewController(TabAssembler.buildModule(), animated: true)
    }
}
