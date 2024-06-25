//
//  WelcomeViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

fileprivate struct Const {
    static let signUp = NSLocalizedString("sighUp", comment: "")
}

class WelcomeViewController: UIViewController {
    //MARK: - Variables
    
    private let signUpButton = SignUpButton()
    private let signInButton = SignInButton()
    private let mainLogo = MainLogo(frame: CGRect())
    private let signInLabel = SignInLabel()
    
    var router: WelcomeRouterProtocol?
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
    //MARK: - UI setup and layout
private extension WelcomeViewController {
    func setupUI() {
        
//        view.backgroundColor = ColorResources.customDarkGrey
        view.backgroundColor = UIColor(
            patternImage: UIImage(named: "backGroundImage")!)
        
        view.setupView(mainLogo)
        view.setupView(signUpButton)
        view.setupView(registrStack)
    }
    
    func setupActions() {
        signUpButton.signUpTapped = { [weak self] in
            guard let self = self else { return }
            self.router?.pushRegistrationScreen()
        }
        
        signInButton.signInTapped = { [weak self ] in
            guard let self = self else { return }
            self.router?.pushAutoristrationScreen()
        }
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            mainLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            signUpButton.bottomAnchor.constraint(equalTo: registrStack.topAnchor, constant: -10),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 250),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
            
            registrStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            registrStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }
}


