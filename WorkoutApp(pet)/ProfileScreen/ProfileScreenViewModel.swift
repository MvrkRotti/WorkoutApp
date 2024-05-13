//
//  ProfileScreenViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
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
    
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(uid).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil)
            return
        }
        
        // Загрузка изображения в Firebase Storage
        let uploadTask = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
            } else {
                storageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Error retrieving download URL: \(error?.localizedDescription ?? "Unknown error")")
                        completion(nil)
                        return
                    }
                    completion(downloadURL.absoluteString)
                }
            }
        }
        uploadTask.resume()
    }
    
    func saveImageURL(_ imageURL: String) {
        UserDefaults.standard.set(imageURL, forKey: "imageURL")
    }
}
