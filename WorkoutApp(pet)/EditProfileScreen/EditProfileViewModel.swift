//
//  EditProfileViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import UIKit

class EditProfileViewModel {
    
    func saveUserData(age: Int, weight: Double, height: Double, gender: String, userID: String) {
        UserDefaults.standard.set(age, forKey: "age_\(userID)")
        UserDefaults.standard.set(weight, forKey: "weight_\(userID)")
        UserDefaults.standard.set(height, forKey: "height_\(userID)")
        UserDefaults.standard.set(gender, forKey: "gender_\(userID)")
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
}

