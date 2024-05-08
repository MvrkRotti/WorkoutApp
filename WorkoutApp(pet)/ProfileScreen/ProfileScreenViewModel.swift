//
//  ProfileScreenViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.05.2024.
//

import Foundation
import UIKit

protocol ProfileViewModelDelegate: AnyObject {
    func didLoadUser(user: User)
}

final class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    var user: User!

    func loadUserProfileData() {
        let defaults = UserDefaults.standard
        let name = defaults.string(forKey: "name") ?? ""
        let gender = defaults.string(forKey: "gender") ?? ""
        let age = defaults.string(forKey: "age") ?? ""
        let weight = defaults.string(forKey: "weight") ?? ""
        let height = defaults.string(forKey: "height") ?? ""
        let bmi = defaults.string(forKey: "bmi") ?? ""
        
        user = User(firstName: name, age: age, gender: gender, weight: weight, height: height, bmi: bmi)
        delegate?.didLoadUser(user: user)
    }
}
