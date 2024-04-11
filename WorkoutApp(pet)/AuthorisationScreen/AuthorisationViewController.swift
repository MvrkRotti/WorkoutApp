//
//  AuthorisationViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 04.02.2024.
//

import UIKit
import FirebaseAuth

final class AuthorisationViewController: UIViewController {
    
    //MARK: - Variables
    
    var router: AutoristaionRouter!
    
    var viewModel = AuthorisationViewModel()
    
    let emailTextField = LogInEmailTextField()
    let passwordTextField = LogInPasswordTextField()
    let authSignInButton = AuthSignInButton()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
        setupUI()
        setupLayout()
        setupActions()
    }
}

private extension AuthorisationViewController {
    
    func navigationBarAppearence() {
        navigationController?.isNavigationBarHidden = false
        title = "Log In"
        navigationController?.navigationBar.barTintColor = ColorResources.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ColorResources.white]
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backGroundImage")!)
        
        let emailTextFieldImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20.0, height: 20.0))
        let image = TextFieldResources.Images.userLogo
        emailTextFieldImageView.image = image
        emailTextFieldImageView.contentMode = .right
        emailTextField.addSubview(emailTextFieldImageView)
        emailTextField.leftViewMode = .always
        emailTextField.leftView = emailTextFieldImageView
        emailTextField.delegate = self
        
        let passwordTextFieldImageView = UIImageView(frame: CGRect(x: 8.0, y: 12.0, width: 20.0, height: 20.0))
        let passImage = TextFieldResources.Images.passLogo
        passwordTextFieldImageView.image = passImage
        passwordTextFieldImageView.contentMode = .scaleAspectFit
        passwordTextField.addSubview(passwordTextFieldImageView)
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = passwordTextFieldImageView
        passwordTextField.delegate = self
        
        view.setupView(emailTextField)
        view.setupView(passwordTextField)
        view.setupView(authSignInButton)
        
    }
    
    func setupActions() {
        authSignInButton.signInTapped = {
            guard let email = self.emailTextField.text, !email.isEmpty,
                  let password = self.passwordTextField.text, !password.isEmpty else {
                self.showAlert(message: StringResources.AlertResources.emptyField)
                return
            }
            self.viewModel.authorisation(email: email, password: password) { [weak self] success, error in
                if error != nil {
                    self?.showAlert(message: StringResources.AlertResources.incorrectFilling)
                } else {
                    self?.router?.pushHomeScreen()
                }
            }
        }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            emailTextField.widthAnchor.constraint(equalToConstant: 335),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.widthAnchor.constraint(equalToConstant: 334),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            authSignInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            authSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authSignInButton.widthAnchor.constraint(equalToConstant: 335),
            authSignInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

private extension AuthorisationViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: StringResources.AlertResources.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.AlertResources.cancelAction, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

