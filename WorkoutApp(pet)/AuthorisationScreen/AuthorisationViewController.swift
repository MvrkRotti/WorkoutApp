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
    
    var router: Router
    var viewModel: AuthorisationViewModel
    
    private let emailTextField = CustomTextField(fieldType: .email)
    private let passwordTextField = CustomTextField(fieldType: .password)
    private let authSignInButton = AuthSignInButton()
    private let resetPasswordButton = AuthResetPasswordButton()
    private let navBarButton = CustomNavBarButton(type: .custom)
    
    private var textFieldArray = [UITextField] ()
    
    
    //MARK: - Lifecycle
    
    init(router: Router, viewModel: AuthorisationViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearance()
        setupUI()
        setupLayout()
        setupActions()
        createTextFieldArray()
        setupHideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}


private extension AuthorisationViewController {
    
    func navigationBarAppearance() {
        title = Const.sighIn
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ColorResources.black]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : FontResources.boldSystemFont26]
        
        let backButton = UIBarButtonItem(customView: navBarButton)
        navBarButton.setTitle(Const.back, for: .normal)
        navBarButton.frame = CGRect(x: 0, y: 0, width: 70, height: 25)
        navBarButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backTapped() {
        self.router.popScreen(from: navigationController)
    }
    
    func setupUI() {
        view.backgroundColor = ColorResources.white
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
                        self?.showAlert(message: Const.incorrectFilling)
                    } else {
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        self?.router.navigateToTabBar(from: self?.navigationController)
                    }
                }
            } else {
                self.showAlert(message: Const.emptyFields)
            }
        }
        
        resetPasswordButton.resetTapped = { [weak self ] in
            guard let self = self else { return }
            self.router.navigateToResetPassword(from: navigationController)
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


