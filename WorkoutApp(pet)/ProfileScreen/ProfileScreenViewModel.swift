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
        guard let weight = weight, let height = height else { return nil }
        let bmiValue = weight / ((height / 100) * (height / 100))
        return bmiValue
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to load image:", error?.localizedDescription ?? "")
                    completion(nil)
                    return
                }
                let image = UIImage(data: data)
                completion(image)
            }
            task.resume()
        }
}
