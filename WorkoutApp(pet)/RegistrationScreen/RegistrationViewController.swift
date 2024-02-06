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
    
    let registrationLabel = RegistrationLabel()
    let nameTextField = NameTextField()
    let lastNameTextField = LastNameTextField()
    let emailTextField = EmailTextField()
    let passwordTextField = PasswordTextField()
    let confirmPasswordTextField = ConfirmPasswordTextField()
    let regSighUpButton = SignUpButton()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
        setupUI()
        setupActions()
        setupLayout()
    }
}

private extension RegistrationViewController {
    
    private func navigationBarAppearence() {
        navigationController?.isNavigationBarHidden = false
        title = "Registration"
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    
    
    private func setupUI() {
        view.backgroundColor = UIColor(
            patternImage: UIImage(named: "backGroundImage")!)
        
        view.setupView(registrationLabel)
        view.setupView(nameTextField)
        view.setupView(lastNameTextField)
        view.setupView(emailTextField)
        view.setupView(passwordTextField)
        view.setupView(confirmPasswordTextField)
        view.setupView(regSighUpButton)


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
            
            nameTextField.widthAnchor.constraint(equalToConstant: 334),
            nameTextField.heightAnchor.constraint(equalToConstant: 44),
            nameTextField.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 45),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastNameTextField.widthAnchor.constraint(equalToConstant: 334),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 44),
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 45),
            lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.widthAnchor.constraint(equalToConstant: 334),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 45),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.widthAnchor.constraint(equalToConstant: 334),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 45),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 334),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 44),
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 45),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            regSighUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regSighUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            regSighUpButton.widthAnchor.constraint(equalToConstant: 200),
            regSighUpButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
