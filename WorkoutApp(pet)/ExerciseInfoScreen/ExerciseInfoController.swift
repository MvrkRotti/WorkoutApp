//
//  ExerciseInfoController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 26.02.2024.
//

import UIKit

final class ExerciseInfoController: UIViewController {
    //MARK: - Variables
    
    //MARK: - UI Components
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    //MARK: - UI Setup
    
}
