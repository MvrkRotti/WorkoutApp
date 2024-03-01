//
//  ExerciseInfoController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 26.02.2024.
//

import UIKit

final class ExerciseInfoController: UIViewController {
    //MARK: - Variables
    
    let viewModel: ExerciseInfoViewModel
    
    private let nameLabel = ExerciseNameLabel()
    private let typeLabel = ExerciseTypeLabel()
    private let muscleLabe = MuscleLabel()
    private let equipmentLabel = EquipmentLabel()
    private let difficultyLabel = DifficultyLabel()
    private let instructionsLabel = InstructionsLabel()

    
    //MARK: - UI Components
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var exerciseInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, muscleLabe, equipmentLabel, difficultyLabel, instructionsLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    
    
    //MARK: - Lifecycle
    init(_ viewModel: ExerciseInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.CommonColors.black
        setupUI()
        
        nameLabel.text = viewModel.nameLabel
        typeLabel.text = viewModel.typeLabel
        muscleLabe.text = viewModel.muscleLabel
        equipmentLabel.text = viewModel.equipmentLabel
        difficultyLabel.text = viewModel.difficultyLabel
        instructionsLabel.text = viewModel.instructionLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}

private extension ExerciseInfoController {
    func setupUI() {
        
        view.setupView(scrollView)
        scrollView.setupView(nameLabel)
        scrollView.setupView(exerciseInfoStack)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            exerciseInfoStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            exerciseInfoStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            exerciseInfoStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            exerciseInfoStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            exerciseInfoStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

