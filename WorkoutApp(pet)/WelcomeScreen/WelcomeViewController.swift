//
//  WelcomeViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit


class WelcomeViewController: UIViewController {
    //MARK: - Variables
    
    private let signUpButton = SignUpButton()
    private let signInButton = SignInButton()
    private let mainLogo = MainLogo(frame: CGRect())
    private let signInLabel = SignInLabel()
    
    var router: Router
    //MARK: - UI Components
    
    private lazy var registrStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signInLabel, signInButton])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        return stack
    }()
    //MARK: - Lifecycle
    init(router: Router) {
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
            self.router.navigateToRegister(from: navigationController)
        }
        
        signInButton.signInTapped = { [weak self ] in
            guard let self = self else { return }
            self.router.navigateToLogin(from: navigationController)
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


