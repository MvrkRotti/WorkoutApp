//
//  RegistrationViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Variables
    
    //MARK: - UI Components
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            patternImage: UIImage(named: "backGroundImage")!)
        navigationBarAppearence()

    }
    
}

private extension RegistrationViewController {
    
    
    
    func navigationBarAppearence() {
        navigationController?.isNavigationBarHidden = false
        title = "Registration"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
