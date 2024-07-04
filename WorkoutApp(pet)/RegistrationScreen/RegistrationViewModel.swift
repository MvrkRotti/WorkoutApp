//
//  RegistrationViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class RegistrationViewModel {
        
    func registerUser(firstName: String, lastName: String, email: String,
                      password: String, confirmPassword: String,
                      completion: @escaping(User?, String?) -> Void)
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
            let userData = User(firstName: firstName, lastName: lastName, email: email, password: password)
            UserDefaults.standard.set(firstName, forKey: "name_\(user.uid)")
            UserDefaults.standard.set(user.uid, forKey: "UserID")
            self.saveUser(userData, forUserID: user.uid)
            completion(userData, nil)
        }
    }
    
    private func saveUser(_ user: User, forUserID userID: String) {
        UserDefaults.standard.set(["name": user.firstName], forKey: "User_ \(userID)")
    }
}


