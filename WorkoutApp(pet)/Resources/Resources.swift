//
//  Resources.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

enum Resources {
    
    enum TextField {
        
        enum PlaceholderString {
            static let firstName = "First Name"
            static let lastName = "Last Name"
            static let email = "Email"
            static let password = "Password"
            static let confirmPassword = "Confirm Password"
            static let age = "Your Age"
            static let weight = "Your Weight"
            static let height = "Your Height"
        }
        
        enum Images {
            static let userLogo = UIImage(named: "userLogoLogIn")
            static let passLogo = UIImage(named: "passwordSignLogIn")
        }
    }
    
    enum CommonStrings {
        static let selectPhoto = "Select\nPhoto"
    }
    
    enum NavigationBarHeaders {
        static let exerciseScreen = "Handbook"
        static let notesScreen = "My Notes"
        static let profileScreen = "My Profile"
    }
    
    enum CommonColors {
        static let customCoral = UIColor(hexString: "#6ADADA")
        static let customDarkGrey = UIColor(hexString: "#393939")
        static let customGray = UIColor(hexString: "#D9D9D9")
        static let white = UIColor(hexString: "#FFFFFF")
        static let black = UIColor(hexString: "#000000")
        static let gradientTopColor = UIColor(hexString: "#007FFF")
        static let gradientMiddleColor = UIColor(hexString: "#65ACF4")
        static let gradientBottomColor = UIColor(hexString: "#82EED4")
    }
    
    enum CommonFonts {
        static let mainLogoFont = UIFont.boldSystemFont(ofSize: 40)
        static let autLabelFont = UIFont.systemFont(ofSize: 15)
        static let registrationLabelFont = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let cellNameLabelFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let profileLabelFont = UIFont.systemFont(ofSize: 22)
        static let bmiDescriptionFont = UIFont.systemFont(ofSize: 12)
    }
    
    enum CommonImages {
        static let mainLogo = UIImage(named: "mainLogoImage")
        static let firstBackgroundImage = UIImage(named: "backGroundImage")
        static let cellArrow = UIImage(named: "cellArrow")
        static let trainNotesBackgoundImage = UIImage(named: "trainNotesBG")
        static let foodNotesBackgoundImage = UIImage(named: "foodNotesBG")
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
    
    enum TabBar {
        
        static func icon(for tab: Tabs) -> UIImage? {
            switch tab {
            case .exercises: return UIImage(named: "ExercisesTabIcon")
            case .notes: return UIImage(named: "notesTabIcon")
            case .profile: return UIImage(named: "porfileTabIcon")
            }
        }
        
        static func title(for tab: Tabs) -> String {
            switch tab {
            case .exercises: return "Handbook"
            case .notes: return "Notes"
            case .profile: return "Profile"
            }
        }
    }
}
