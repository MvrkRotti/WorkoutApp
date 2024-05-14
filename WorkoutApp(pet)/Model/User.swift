//
//  User.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import Foundation
import UIKit

struct User: Codable {
    var profileImageURL: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var age: String?
    var gender: String?
    var weight: String?
    var height: String?
    var bmi: String?
    var bmiDescription: String?
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
}
