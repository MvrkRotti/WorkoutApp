//
//  User.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import Foundation
import UIKit
import FirebaseFirestoreSwift
import FirebaseAuth

struct AppUser: Codable, Identifiable {
    @DocumentID var id: String?
    var profileImageURL: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var password: String?
    var age: Int?
    var gender: String?
    var weight: Double?
    var height: Double?
    var bmi: String?
    var bmiDescription: String?
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
}
