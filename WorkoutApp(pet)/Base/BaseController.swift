//
//  BaseController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupActions()
    }
}

@objc extension BaseController {
    
    func setupUI() {}
    
    func setupLayout() {}
    
    func setupActions() {}
}
