//
//  WelcomeViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

class WelcomeViewController: UINavigationController {
    
    //MARK: - Variables
    
    let signUpButton = SignUpButton()
    
    var router: Router?
    
//    init(router: Router) {
//        self.router = router
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    
    //MARK: - UI Components
    
    private let mainLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Resources.Images.mainLogo
        return imageView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.customWhite
        label.textAlignment = .left
        label.font = Resources.Fonts.autLabelFont
        label.text = Resources.autorizedScreen.alreadyHaveAcc
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Resources.Colors.customOrange, for: .normal)
        let buttonTitleStr = NSMutableAttributedString(string: Resources.autorizedScreen.signIn)
        buttonTitleStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, buttonTitleStr.length))
        button.setAttributedTitle(buttonTitleStr, for: .normal)
        return button
    }()
    
    private lazy var registrStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signInLabel, signInButton])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        return stack
    }()
    
    func showAlert() {
    let alert = UIAlertController(title: "Congrats", message: "Your button is working!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        
        view.backgroundColor = Resources.Colors.customGrey
        
        view.addSubview(mainLogo)
        view.addSubview(signUpButton)
        view.addSubview(registrStack)
        
        signUpButton.signUpTapped = { [weak self] in
            guard let self = self else { return }
            self.router?.pushRegistrationViewController()
        }
        
        self.mainLogo.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.registrStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.mainLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.mainLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.signUpButton.bottomAnchor.constraint(equalTo: registrStack.topAnchor, constant: -50),
            self.signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.signUpButton.widthAnchor.constraint(equalToConstant: 150),
            
            self.registrStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            self.registrStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            self.registrStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            self.registrStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }
}

