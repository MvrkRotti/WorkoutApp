//
//  RegistrationViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class RegistrationViewModel {
    
    private let db = Firestore.firestore()
        
    func registerUser(firstName: String, lastName: String, email: String,
                      password: String, confirmPassword: String,
                      completion: @escaping(AppUser?, String?) -> Void)
    {
        guard password == confirmPassword else {
            completion(nil, "Password do not match")
            return
        }
                
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                if let error = error {
                    completion(nil, "Registration failed: \(error.localizedDescription)")
                }
                return
            }
            let userData = AppUser(firstName: firstName, lastName: lastName, email: email, password: password)
            
            self.saveUserToFirestore(userData, forUserID: user.uid) { error in
                if let error = error {
                    completion(nil, "Failed to save user data: \(error.localizedDescription)")
                } else {
                    completion(userData, nil)
                }
            }
        }
    }
    
    private func saveUserToFirestore(_ user: AppUser, forUserID userID: String, completion: @escaping(Error?) -> Void ) {
        let userStorage = db.collection("users").document(userID)
        let data: [String: Any] = [ "name": user.firstName as Any ]
        
        userStorage.setData(data) { error in
            completion(error)
        }
    }
}


