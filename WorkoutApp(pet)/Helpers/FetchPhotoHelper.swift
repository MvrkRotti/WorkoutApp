//
//  FetchPhotoHelper.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 14.05.2024.
//

import FirebaseAuth
import FirebaseStorage
import UIKit

final class FetchProfilePhoto {
    static func fetchProfileImage(completion: @escaping (UIImage?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(uid).jpg")
        storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error downloading profile image: \(error)")
                completion(nil)
            } else {
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    completion(image)
                }
            }
        }
    }
}
