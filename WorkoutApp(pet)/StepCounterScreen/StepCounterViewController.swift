//
//  StepCounterViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit
import Charts
import DGCharts
import Combine

class StepCounterViewController: UIViewController {
    //MARK: - Variables
    
    private let viewModel: StepViewModel
    private var cancellables = Set<AnyCancellable>()
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
        bindViewModel()
        viewModel.fetchUserData()
    }
}

private extension StepCounterViewController {
    
    //MARK: - setupUI
    
    private func setupUI() {
        
        navigationItem.title = Const.stepCounterMainTitle
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = .clear
        
        progressView.addSubview(stepsStack)
        
        view.addSubview(setGoalButton)
        
        view.addSubview(weekChart)
        weekChart.translatesAutoresizingMaskIntoConstraints = false
        
        setGoalButton.addTarget(self, action: #selector(setGoalButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK: - SetupLayout
    
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
            setGoalButton.widthAnchor.constraint(equalTo: progressView.widthAnchor),
            
            weekChart.topAnchor.constraint(equalTo: setGoalButton.bottomAnchor, constant: 30),
            weekChart.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weekChart.widthAnchor.constraint(equalTo: setGoalButton.widthAnchor),
            weekChart.heightAnchor.constraint(equalToConstant: view.bounds.height / 5)
        ])
    }
    
    //MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.$dailyGoal
                    .receive(on: DispatchQueue.main)
                    .sink { [ weak self] goal in
                        self?.goalLabel.text = Const.goalTitle + "\(goal)"
                    }
                    .store(in: &cancellables)
        
        viewModel.$currentSteps
            .receive(on: DispatchQueue.main)
            .sink { [weak self] steps in
                guard let self = self else { return }
                let dailyGoal = self.viewModel.dailyGoal > 0 ? self.viewModel.dailyGoal : 10_000
                let progress = Float(steps) / Float(dailyGoal)
                
                print("Steps: \(steps), Daily Goal: \(dailyGoal), Progress: \(progress)")
                
                self.progressView.progress = min(max(progress, 0.0), 1.0)
                
                self.stepsLabel.text = "\(steps)"
            }
            .store(in: &cancellables)
        
        viewModel.$weeklySteps
            .receive(on: DispatchQueue.main)
            .sink { [weak self] weeklySteps in
                self?.weekChart.updateData(steps: weeklySteps)
            }
            .store(in: &cancellables)
    }
    
    
    @objc private func setGoalButtonTapped() {
        let alertController = UIAlertController(title: Const.setDailyGoalTitle, message: Const.numberOfStepsTitle, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.keyboardType = .numberPad
            textField.placeholder = "10000"
        }
        let confirmAction = UIAlertAction(title: Const.okAction, style: .default) { [weak self] _ in
            if let text = alertController.textFields?.first?.text, let goal = Int(text), goal > 0, goal < 1_000_000 {
                self?.viewModel.setDailyGoal(goal: goal)
            }
        }
        let cancelAction = UIAlertAction(title: Const.cancelAction, style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
