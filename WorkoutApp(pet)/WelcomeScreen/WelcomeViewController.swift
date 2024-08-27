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
    private let backgroundImageView: UIImageView = {
       let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "backGroundImage")
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    private let buttonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = ColorResources.customBlue
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var registrStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signInLabel, buttonContainer])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.distribution = .fill
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
        
        view.addSubview(backgroundImageView)
        view.setupView(mainLogo)
        view.setupView(signUpButton)
        buttonContainer.addSubview(signInButton)
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
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            signInButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor),
            signInButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor),
            
            mainLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainLogo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height / 6),
            
            signUpButton.bottomAnchor.constraint(equalTo: registrStack.topAnchor, constant: -self.view.bounds.height / 29),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 1.11),
            signUpButton.heightAnchor.constraint(equalToConstant: self.view.bounds.height / 15),
            
            registrStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            registrStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }
}


