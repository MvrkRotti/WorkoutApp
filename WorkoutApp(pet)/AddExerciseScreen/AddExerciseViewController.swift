//
//  AddExerciseViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.04.2024.
//

import UIKit

protocol AddExerciseDelegate: AnyObject {
    func didAddExercise(_ exercise: Exercise)
}

final class AddExerciseViewController: UIViewController {
    
    //MARK: - Variables
    
    var router: AddExerciseRouter
    
    weak var delegate: AddExerciseDelegate?
        
    private let exerciseNameTextField = AddNoteCustomTextField(fieldType: .exerciseName)
    private let numberOfSetsTextField = AddExerciseCustomTextField(fieldType: .numberOfSets)
    private let numberOfRepsTextField = AddExerciseCustomTextField(fieldType: .numberOfReps)
    private let restTimeTextField = AddExerciseCustomTextField(fieldType: .restTime)
    
    private let setsLabel = AddExerciseCustomLabel(labelType: .sets)
    private let repsLabel = AddExerciseCustomLabel(labelType: .reps)
    private let minLabel = AddExerciseCustomLabel(labelType: .min)
    
    private let cancelButton = AddExerciseCustomButton(buttonType: .cancel)
    private let saveButton = AddExerciseCustomButton(buttonType: .save)
    
    //MARK: - UI Components
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [numberOfSetsTextField, numberOfRepsTextField, restTimeTextField])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [setsLabel, repsLabel, minLabel])
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 40
        return stack
    }()
    
    //MARK: - Lifecycle
    
    init(router: AddExerciseRouter = AddExerciseRouter()) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupActions()
    }
}
//MARK: - UI Setup
private extension AddExerciseViewController {
    
    func setupUI() {
        
        view.backgroundColor = ColorResources.customDarkGrey
        view.setupView(exerciseNameTextField)
        view.setupView(textFieldStack)
        view.setupView(labelStack)
        view.setupView(buttonStack)
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            exerciseNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            exerciseNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exerciseNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textFieldStack.topAnchor.constraint(equalTo: exerciseNameTextField.bottomAnchor, constant: 20),
            textFieldStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            labelStack.topAnchor.constraint(equalTo: exerciseNameTextField.bottomAnchor, constant: 20),
            labelStack.leadingAnchor.constraint(equalTo: textFieldStack.trailingAnchor, constant: 15),
            labelStack.bottomAnchor.constraint(equalTo: textFieldStack.bottomAnchor),
            
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setupActions() {
        cancelButton.cancelButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        
        saveButton.saveButtonTapped = {
            guard let exerciseName = self.exerciseNameTextField.text, !exerciseName.isEmpty,
                  let numberOfSets = self.numberOfSetsTextField.text, !numberOfSets.isEmpty,
                  let numberOfReps = self.numberOfRepsTextField.text, !numberOfReps.isEmpty,
                  let restTime = self.restTimeTextField.text, !restTime.isEmpty else { return }
            
            let exercise = Exercise(exerciseName: exerciseName, numberOfSets: numberOfSets, numberOfReps: numberOfReps, restTime: restTime)
            self.delegate?.didAddExercise(exercise)
        }
    }
}

