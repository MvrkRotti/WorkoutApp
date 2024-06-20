//
//  ResetPasswordViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

final class ResetPasswordViewController: UIViewController {
    
    //MARK: - Variables
    var router: ResetPasswordRouter!
    
    var viewModel = ResetPasswordViewModel()
    
    private let emailTextField = ResetEmailTextField()
    private let infoLabel = ResetLabel()
    private let resetButton = ResetPasswordButton()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func resetPasswordDidSucceed() {
        self.router.popScreen()
    }
    
    func resetPasswordDidFail(with error: Error) {
        showAlert(message: error.localizedDescription)
    }
}

//MARK: - UI Setup
private extension ResetPasswordViewController {
    func setupUI() {
        view.backgroundColor = ColorResources.black
        
        navigationItem.title = StringResources.NavigationBarHeaders.resetPassword
        
        view.setupView(emailTextField)
        view.setupView(infoLabel)
        view.setupView(resetButton)
    }
    
    //MARK: - Setup Layout
    func setupLayout() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK: - Setup Action
    
    func setupAction() {
        resetButton.resetTapped = {
            guard let email = self.emailTextField.text, !email.isEmpty else {
                self.showAlert(message: StringResources.AlertResources.enterEmail)
                return }
            self.viewModel.resetPassword(forEmail: email) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        self?.showSuccessAlert()
                    case .failure(let error):
                        self?.showAlert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
}

    //MARK: - Alert Controllers
private extension ResetPasswordViewController {
    
    func showSuccessAlert() {
        let alertController = UIAlertController(title: StringResources.NavigationBarHeaders.resetPassword, message: StringResources.AlertResources.resetPassInfo, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.router.popScreen()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

