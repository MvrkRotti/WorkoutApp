//
//  AddNoteViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

final class AddNoteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        navigationBarAppearence()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}

private extension AddNoteViewController {
    func navigationBarAppearence() {
        navigationController?.navigationItem.title = "Add note"
    }
}
