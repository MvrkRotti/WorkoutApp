//
//  HomeScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

final class HandbookScreenViewController: UIViewController {
    //MARK: - Variables
    private let viewModel: HandbookViewModel
    private let tableView = UITableView()
    private let activityIndicator = CustomActivityIndicator(frame: CGRect(), text: "Loading")
    
    //MARK: - Lifecycle
    init(_ viewModel: HandbookViewModel = HandbookViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        navigationBarAppearance()
        setupUI()
        setupLayout()
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
}

    //MARK: - UI setup and layout
private extension HandbookScreenViewController {
    
    func setupUI() {
        tableView.backgroundColor = ColorResources.black
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
    
    func navigationBarAppearance() {
        navigationItem.title = "Home"
        navigationController?.isNavigationBarHidden = false
//        navigationController?.navigationBar.barTintColor = ColorResources.customDarkGrey
//       navigationController?.navigationBar.alpha = 0.9
        navigationController?.navigationBar.backgroundColor = ColorResources.customDarkGrey
        tabBarController?.tabBar.backgroundColor = ColorResources.customDarkGrey
    }
    
    func tableViewSettings() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HandbookCell.self, forCellReuseIdentifier: HandbookCell.identifier)

        viewModel.handbookExerciseUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HandbookScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.allExercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HandbookCell.identifier, for: indexPath) as? HandbookCell else { fatalError("Unable to dequeue CoinCell in HomeController") }
        let exercise = viewModel.allExercises[indexPath.row]
        cell.configure(with: exercise)
        activityIndicator.stopAnimating()
        cell.backgroundColor = .clear
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
        present(viewController, animated: true, completion: nil)
    }
    
    
}
