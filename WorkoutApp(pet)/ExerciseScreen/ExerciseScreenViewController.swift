//
//  HomeScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

final class ExerciseScreenViewController: UIViewController {
    //MARK: - Variables
    private let viewModel: ExerciseViewModel
    var router: HomeRouter!
    private let tableView = UITableView()
    private let activityIndicator = CustomActivityIndicator(frame: CGRect(), text: "Loading")
    
    //MARK: - Lifecycle
    init(_ viewModel: ExerciseViewModel = ExerciseViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        navigationBarAppearence()
        setupUI()
        setupLayout()
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            tabBarController?.tabBar.isHidden = false
        }
    
}

private extension ExerciseScreenViewController {
    
    func setupUI() {
        view.setupView(tableView)
        tableView.setupView(activityIndicator)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func navigationBarAppearence() {
        navigationItem.title = "Home"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.CommonColors.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
    }
    
    func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: ExerciseCell.identifier)

        viewModel.exerciseUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}


extension ExerciseScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.allExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseCell.identifier, for: indexPath) as? ExerciseCell else { fatalError("Unable to dequeue CoinCell in HomeController") }
        let exercise = viewModel.allExercises[indexPath.row]
        cell.configure(with: exercise)
        activityIndicator.stopAnimating()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let exercise = viewModel.allExercises[indexPath.row]
        
        let viewModel = ExerciseInfoViewModel(exercise)
        let viewController = ExerciseInfoController(viewModel)
//        self.navigationController?.pushViewController(vc, animated: true)
        present(viewController, animated: true, completion: nil)
    }
    
    
}
