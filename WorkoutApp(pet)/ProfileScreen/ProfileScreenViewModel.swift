//
//  ProfileScreenViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.05.2024.
//

import Foundation
import FirebaseAuth
import UIKit

final class ProfileViewModel {
    var userID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    var name: String? {
        guard let userID = userID else { return nil}
        return UserDefaults.standard.string(forKey: "name_\(userID)")
    }
    
    var age: Int? {
        guard let userID = userID else { return nil }
        return UserDefaults.standard.integer(forKey: "age_\(userID)")
    }
    
    var weight: Double? {
        guard let userID = userID else { return nil }
        return UserDefaults.standard.double(forKey: "weight_\(userID)")
    }
    
    var height: Double? {
        guard let userID = userID else { return nil }
        return UserDefaults.standard.double(forKey: "height_\(userID)")
    }
    
    var gender: String? {
        guard let userID = userID else { return nil }
        return UserDefaults.standard.string(forKey: "gender_\(userID)")
    }
    
    var bmi: Double? {
        guard let weight = weight, let height = height else { return 0 }
        let bmiValue = weight / ((height / 100) * (height / 100))
        return bmiValue
    }
    
    func getBMIDesctription(bmi: Double) -> String {
        let underweightRange = 0.0..<18.5
        let normalRange = 18.5..<24.9
        let overweightRange = 24.9..<29.9
        let veryOverweightRange = 30.0...
        
        if underweightRange.contains(bmi) {
            return Const.BMILowIntex
        } else if normalRange.contains(bmi) {
            return Const.BMINormalIndex
        } else if overweightRange.contains(bmi) {
            return Const.BMIOverweightIndex
        } else if veryOverweightRange.contains(bmi) {
            return Const.BMIVeryOverweightIndex
        } else {
            return Const.nonHeightAndWeight
        }
    }
    
    var bmiDescription: String? {
        guard let bmi = bmi else { return "No data" }
        let bmiDescriprion = getBMIDesctription(bmi: bmi)
        return bmiDescriprion
    }
    
    var textColor: UIColor {
        guard let bmi = bmi else { return .black }
        
        switch bmi {
        case ..<18.5:
            return ColorResources.customMainBlue
        case 18.5..<24.9:
            return ColorResources.customGreen
        case 24.9..<30.0:
            return ColorResources.customOrange
        case 30.0...:
            return ColorResources.customRed
        default:
            return ColorResources.black
        }
    }
}
