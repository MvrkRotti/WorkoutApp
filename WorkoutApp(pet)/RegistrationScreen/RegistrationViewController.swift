//
//  RegistrationViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //MARK: - Variables
    
    var router: RegistrationRouter!
    
    private let registrationLabel = RegistrationLabel()
     let nameField = CustomTextField(fieldType: .name)
     let lastNameField = CustomTextField(fieldType: .lastName)
     let emailField = CustomTextField(fieldType: .email)
     let passwordField = CustomTextField(fieldType: .password)
     let confirmPasswordField = CustomTextField(fieldType: .confirmPassword)
    private let regSighUpButton = SignUpButton()
    //MARK: - UIComponents
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField, lastNameField, emailField, passwordField, confirmPasswordField])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
        setupUI()
        setupTextFieldDelegate()
        setupActions()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

private extension RegistrationViewController {
    
    private func navigationBarAppearence() {
        title = "Registration"
        navigationController?.navigationBar.barTintColor = Resources.CommonColors.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Resources.CommonColors.white]
    }
    
    
    
    private func setupUI() {
        view.backgroundColor = UIColor(
            patternImage: UIImage(named: "backGroundImage")!)
        
        view.setupView(registrationLabel)
        view.setupView(textFieldStack)
        view.setupView(regSighUpButton)
    }
    
    private func setupTextFieldDelegate() {
        nameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
    }
    
    private func setupActions() {
        regSighUpButton.signUpTapped = { [weak self] in
            guard let self = self else { return }
            self.router?.pushHomeScreen()
        }
    }
    
    private func setupLayout() {

        NSLayoutConstraint.activate([
            registrationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            registrationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            textFieldStack.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 30),
            textFieldStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldStack.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            regSighUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regSighUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            regSighUpButton.widthAnchor.constraint(equalToConstant: 335),
            regSighUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            confirmPasswordField.becomeFirstResponder()
        case confirmPasswordField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
}

