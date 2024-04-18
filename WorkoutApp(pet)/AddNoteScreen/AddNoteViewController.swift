//
//  AddNoteViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

final class AddNoteViewController: UIViewController {
    
    //MARK: - Variables
    
    let viewModel: AddNoteViewModel
    let router: RouterProtocol
    
    private let trainingNameTextField = AddNoteCustomTextField(fieldType: .trainingName)
    private let muscleTextField = AddNoteCustomTextField(fieldType: .kindOfMuscle)
    private let tableView = UITableView(frame: .zero)
    private let addExerciseButton = AddExerciseButton()
    
//    var router: AddNoteRouter
    
    //MARK: - UI Components
    
    private lazy var textFieldStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [trainingNameTextField, muscleTextField])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    //MARK: - Lifecycle
    
    init(_ viewModel: AddNoteViewModel, router: RouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        setupUI()
        tableViewSettings()
        setupLayout()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}
    
    //MARK: - Setup UI
private extension AddNoteViewController {
    func navigationBarAppearance() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
        
        navigationItem.title = "Add note"
        navigationItem.rightBarButtonItem = saveButton
    }

    func setupUI() {
        view.backgroundColor = ColorResources.customDarkGrey

        view.setupView(textFieldStack)
        view.setupView(tableView)
        view.setupView(addExerciseButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            textFieldStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textFieldStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: textFieldStack.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: addExerciseButton.topAnchor, constant: -30),
            
            addExerciseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addExerciseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 92),
            addExerciseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -92),
        ])
    }
    
    //MARK: - TableView ssettings
    func tableViewSettings() {
        tableView.backgroundColor = ColorResources.customDarkGrey
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    //MARK: - Setup Action
    func setupAction() {
        addExerciseButton.addExerciseButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.router.presentNextScreen(on: self, delegate: self)
        }
    }
}

extension AddNoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.exercises[indexPath.row].exerciseName
        cell.backgroundColor = ColorResources.customDarkGrey
        return cell
    }
}


extension AddNoteViewController: AddExerciseDelegate {
    func didAddExercise(exerciseName: String, numberOfSets: String, numberOfReps: String, restTime: String) {
        viewModel.addExercise(exerciseName: exerciseName, numberOfSets: numberOfSets, numberOfReps: numberOfReps, restTime: restTime)
        tableView.reloadData()
    }
    
    
}

