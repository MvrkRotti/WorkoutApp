//
//  AuthorizationViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import Foundation
import FirebaseAuth

final class AuthorisationViewModel {
    func authorisation(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
