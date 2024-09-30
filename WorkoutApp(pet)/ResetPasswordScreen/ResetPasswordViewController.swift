//
//  ResetPasswordViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

final class ResetPasswordViewController: UIViewController {
    
    //MARK: - Variables
    var router: Router
    var viewModel: ResetPasswordViewModel
    
    private let emailTextField = RegistrationCustomTextField(fieldType: .email)
    private let infoLabel = ResetLabel()
    private let resetButton = ResetPasswordButton()
    
    //MARK: - Lifecycle
    
    init(router: Router, viewModel: ResetPasswordViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        self.router.popScreen(from: navigationController)
    }
    
    func resetPasswordDidFail(with error: Error) {
        showAlert(message: error.localizedDescription)
    }
}

//MARK: - UI Setup
private extension ResetPasswordViewController {
    func setupUI() {
        view.backgroundColor = ColorResources.white
        
        navigationItem.title = Const.resetPassword
        
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
                self.showAlert(message: Const.enterEmail)
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
        let alertController = UIAlertController(title: Const.resetPassword, message: Const.resetPassInfo, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.router.popScreen(from: self.navigationController)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

