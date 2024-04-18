//
//  ResetPasswordViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import Foundation
import UIKit
import FirebaseAuth

enum ResetPasswordError: Error {
    case invalidEmail
    case resetFailed
    case emailNotFound
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidEmail:
            return "Invalid email format."
        case .resetFailed:
            return "Password reset failed. Please try again."
        case .emailNotFound:
            return "Email not found. Please check your email address."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

final class ResetPasswordViewModel {
    
    func resetPassword(forEmail email: String, completion: @escaping (Result<Void, ResetPasswordError>) -> Void) {
            guard isValidEmail(email) else {
                completion(.failure(.invalidEmail))
                return
            }
            
            Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
                if let error = error as NSError? {
                    if error.code == AuthErrorCode.userNotFound.rawValue {
                        completion(.failure(.emailNotFound))
                    } else {
                        completion(.failure(.unknownError))
                    }
                } else {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error as NSError? {
                            switch error.code {
                            case AuthErrorCode.invalidEmail.rawValue:
                                completion(.failure(.invalidEmail))
                            default:
                                completion(.failure(.resetFailed))
                            }
                        } else {
                            completion(.success(()))
                        }
                    }
                }
            }
        }
        
        private func isValidEmail(_ email: String) -> Bool {
            return email.contains("@")
        }

}
