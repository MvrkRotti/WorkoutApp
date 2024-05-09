//
//  EditProfileViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.05.2024.
//

import Foundation

class EditProfileViewModel {
    
    func saveUserData(age: Int, weight: Double, height: Double, gender: String, userID: String) {
        UserDefaults.standard.set(age, forKey: "age_\(userID)")
        UserDefaults.standard.set(weight, forKey: "weight_\(userID)")
        UserDefaults.standard.set(height, forKey: "height_\(userID)")
        UserDefaults.standard.set(gender, forKey: "gender_\(userID)")
    }
    
}

