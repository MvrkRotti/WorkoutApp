//
//  StepCounterViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit
//import Charts
//import DGCharts
import Combine

class StepCounterViewController: UIViewController {
    //MARK: - Variables
    
    private let viewModel: StepViewModel
    private let router: Router
    
    private let progressView = CircleProgressView()
    private let weekChart = WeekChartView()
    private let stepsLabel = StepsLabel()
    private let goalLabel = GoalLabel()
    private let setGoalButton = SetGoalButton()
    
    private lazy var stepsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stepsLabel, goalLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    //MARK: - Lifecycle
    
    init(viewModel: StepViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
        addNavigationBarSeparator()
        addTabBarSeparator()
    }
}

private extension StepCounterViewController {

    //MARK: - setupUI
    
    private func setupUI() {
        
        navigationItem.title = "Step Counter"
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = .clear
        
        progressView.addSubview(stepsStack)
                
        view.addSubview(setGoalButton)
    }
    
    
    //MARK: - SEtupLayout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: view.bounds.width / 1.5),
            progressView.heightAnchor.constraint(equalTo: progressView.widthAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stepsStack.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            stepsStack.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            
            setGoalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setGoalButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            setGoalButton.heightAnchor.constraint(equalToConstant: view.bounds.height / 20),
            setGoalButton.widthAnchor.constraint(equalTo: progressView.widthAnchor)
        ])
    }
}
