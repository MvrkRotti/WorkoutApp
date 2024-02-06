//
//  WelcomeViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Variables
    
    let signUpButton = SignUpButton()
    let signInButton = SignInButton()
    let mainLogo = MainLogo(frame: CGRect())
    let signInLabel = SignInLabel()
    
    var router: WelcomeRouter!
    
    
    
    //MARK: - UI Components
    
    private lazy var registrStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signInLabel, signInButton])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        return stack
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
}

private extension WelcomeViewController {
    private func setupUI() {
        
        view.backgroundColor = Resources.Colors.customGrey
        
        view.addSubview(mainLogo)
        view.addSubview(signUpButton)
        view.addSubview(registrStack)
        
    }
    
    private func setupActions() {
        signUpButton.signUpTapped = { [weak self] in
            guard let self = self else { return }
            self.router?.pushRegistrationScreen()
        }
        
        signInButton.signInTapped = { [weak self ] in
            guard let self = self else { return }
            self.router?.pushAutoristrationScreen()
        }
        
        
    }
    
    private func setupLayout() {
        
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        registrStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            signUpButton.bottomAnchor.constraint(equalTo: registrStack.topAnchor, constant: -50),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 150),
            
            registrStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            registrStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
        
    }
}


