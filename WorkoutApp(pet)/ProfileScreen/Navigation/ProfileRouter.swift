//
//  ProfileRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

final class ProfileRouter {
    
    weak var profileController: ProfileScreenViewController?

    func pushEditScreen() {
        profileController?.navigationController?.pushViewController(EditProfileScreenAssembler.buildModule(), animated: true)
    }
}
