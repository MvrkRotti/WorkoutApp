//
//  StringResources.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import UIKit

enum StringResources {
    enum CommonStrings {
        static let selectPhoto = "Select\nPhoto"
        static let sets = "Sets"
        static let reps = "Reps"
        static let min = "Min"
        static let save = "SAVE"
        static let cancel = "CANCEL"
    }
    
    enum NavigationBarHeaders {
        static let exerciseScreen = "Handbook"
        static let notesScreen = "My Notes"
        static let profileScreen = "My Profile"
    }
    

    
    enum AutorizedScreenStrings {
        static let signIn = "Sign In"
        static let signUp = "Sign Up"
        static let alreadyHaveAcc = "Already have an account?"
    }
    
    enum RegistrationScreenStrings {
        static let navBarText = "Registration"
        static let registrationLabel = "Create your account"
    }
    
    enum AlertResources {
        static let fillAllFields = "Please, fill in all fields"
        static let emptyField = "Email or password is empty"
        static let incorrectFilling = "Email or password is empty"
        static let alertTitle = "Alert"
        static let cancelAction = "Try Again"
    }
}
