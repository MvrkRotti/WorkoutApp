//
//  HomeScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

final class HomeScreenViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationBarAppearence()
    }
}

extension HomeScreenViewController {
    
    private func navigationBarAppearence() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.Colors.customGrey
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController?.navigationBar.alpha = 0.9
    }
}
