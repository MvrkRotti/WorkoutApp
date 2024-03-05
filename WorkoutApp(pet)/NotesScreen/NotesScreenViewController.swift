//
//  NotesViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

final class NotesScreenViewController: UIViewController {
    //MARK: - Variables
    
    private let trainView = TrainNotesView(frame: CGRect())
    private let foodView = FoodNotesView(frame: CGRect())
    private let traintableView = TrainTableView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
        setupUI()
        setupLayout()
    }
    
}

extension NotesScreenViewController {
    
    func navigationBarAppearence() {
        navigationItem.title = "My Notes"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.CommonColors.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
    }
    //MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = Resources.CommonColors.customDarkGrey

        view.setupView(trainView)
        view.setupView(foodView)
        trainView.setupView(traintableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            trainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            trainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            trainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            traintableView.topAnchor.constraint(equalTo: trainView.topAnchor, constant: 43),
            traintableView.leadingAnchor.constraint(equalTo: trainView.leadingAnchor, constant: 20),
            traintableView.trailingAnchor.constraint(equalTo: trainView.trailingAnchor, constant: -20),
            traintableView.bottomAnchor.constraint(equalTo: trainView.bottomAnchor, constant: -82),
            
            foodView.topAnchor.constraint(equalTo: trainView.bottomAnchor, constant: 20),
            foodView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            foodView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            foodView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

