//
//  Resources.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

enum Resources {
    enum Colors {
        static let customOrange = UIColor(hexString: "#FB7445")
        static let customRed = UIColor(hexString: "#EE373F")
        static let customGrey = UIColor(hexString: "#393939")
        static let customWhite = UIColor(hexString: "#FFFFFF")
    }
    
    enum Fonts {
        static let mainLogoFont = UIFont.boldSystemFont(ofSize: 40)
        static let autLabelFont = UIFont.systemFont(ofSize: 15)
    }
    
    enum Images {
        static let mainLogo = UIImage(named: "mainLogoImage")
        static let firstBackgroundImage = UIImage(named: "backGroundImage")
    }
    
    enum autorizedScreen {
        static let signIn = "Sign In"
        static let signUp = "Sign Up"
        static let alreadyHaveAcc = "Already have an account?"
    }
    
    enum RegistrationScreen {
        static let navBarText = "Registration"
        static let registrationLabel = "Create your account"
    }
}
