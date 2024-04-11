//
//  RegistrationViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import Foundation
import FirebaseAuth

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
            if let error = error {
                completion(nil, "Registration failed: \(error.localizedDescription)")
            } else if authResult != nil {
                let user = User(firstName: firstName, lastName: lastName, email: email, password: password)
                completion(user, nil)
            }
        }
    }
}


