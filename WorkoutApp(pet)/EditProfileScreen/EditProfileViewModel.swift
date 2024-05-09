//
//  EditProfileViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.05.2024.
//

import Foundation

class EditProfileViewModel {
    
    var user: User?

    init(user: User) {
        self.user = user
    }
    
    func saveUserProfileData(user: User) {
            let defaults = UserDefaults.standard
        defaults.set(user.gender, forKey: "gender \(user.)")
            defaults.set(user.age, forKey: "age")
            defaults.set(user.weight, forKey: "weight")
            defaults.set(user.height, forKey: "height")
            defaults.set(user.bmi, forKey: "bmi")
        }

}

