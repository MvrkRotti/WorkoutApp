//
//  EditProfileViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.05.2024.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import UIKit

class EditProfileViewModel {
    
    private let db = Firestore.firestore()
    
    func saveUserData(age: Int, weight: Double, height: Double, gender: String, completion: @escaping(Bool, String?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(false, "User not logged in")
            return
        }
        
        let userStorage = db.collection("users").document(userID)
        let data: [String: Any] = [
            "age": age,
            "weight": weight,
            "height": height,
            "gender": gender
        ]
        userStorage.updateData(data) { error in
            if let error = error {
                completion(false, "Failed to save user data: \(error.localizedDescription)")
            } else {
                completion(true, nil)
            }
        }
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

