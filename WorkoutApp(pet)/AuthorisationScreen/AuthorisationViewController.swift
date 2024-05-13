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
    private let resetPasswordButton = AuthResetPasswordButton()
    
    private var textFieldArray = [UITextField] ()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        setupUI()
        setupLayout()
        setupActions()
        createTextFieldArray()
    }
}

private extension AuthorisationViewController {
    
    func navigationBarAppearance() {
        navigationController?.isNavigationBarHidden = false
        title = "Log In"
        navigationController?.navigationBar.barTintColor = ColorResources.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ColorResources.white]
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backGroundImage")!)
        
        view.setupView(emailTextField)
        view.setupView(passwordTextField)
        view.setupView(authSignInButton)
        view.setupView(resetPasswordButton)
    }
    
    func setupActions() {
        authSignInButton.signInTapped = {
            if ValidateField.voidValidateFields(textFields: self.textFieldArray) {
                guard let email = self.emailTextField.text, !email.isEmpty,
                      let password = self.passwordTextField.text, !password.isEmpty else {
                    return
                }
                self.viewModel.authorisation(email: email, password: password) { [weak self] success, error in
                    if error != nil {
                        self?.showAlert(message: StringResources.AlertResources.incorrectFilling)
                    } else {
                        self?.router?.pushHomeScreen()
                    }
                }
            } else {
                self.showAlert(message: StringResources.AlertResources.emptyField)
            }
        }
        
        resetPasswordButton.resetTapped = { [weak self ] in
            guard let self = self else { return }
            self.router.pushResetPasswordScreen()
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
            
            authSignInButton.bottomAnchor.constraint(equalTo: resetPasswordButton.topAnchor, constant: -10),
            authSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authSignInButton.widthAnchor.constraint(equalToConstant: 335),
            authSignInButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetPasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func createTextFieldArray() {
        textFieldArray.append(emailTextField)
        textFieldArray.append(passwordTextField)
    }
}

private extension AuthorisationViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: StringResources.AlertResources.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.AlertResources.cancelAction, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AuthorisationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            view.endEditing(true)
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for textField in textFieldArray {
            if textField.text?.isEmpty ?? true {
                textField.layer.borderWidth = 1.0
                textField.layer.borderColor = ColorResources.emptyTextFieldBorderColor.cgColor
            } else {
                textField.layer.borderWidth = 0.0
            }
        }
    }
}


