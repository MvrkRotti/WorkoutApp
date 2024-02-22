//
//  ProfileScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

final class ProfileScreenViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
    }
    
    func navigationBarAppearence() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)
        
        navigationItem.title = "My Profile"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.Colors.customGrey
        navigationController?.navigationBar.alpha = 0.9
        navigationItem.rightBarButtonItem = editButton
    }
}
