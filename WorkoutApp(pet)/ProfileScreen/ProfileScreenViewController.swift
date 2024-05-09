//
//  ProfileScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

final class ProfileScreenViewController: UIViewController {
    
    //MARK: - Variables
    
    var router: ProfileRouter?
    //    var user: User?
    var viewModel: ProfileViewModel
    
    private let photoView = ProfilePhotoView(frame: CGRect())
    private let photoLabel = PhotoLabel()
    private let nameLabel = NameLabel()
    private let genderLabel = GenderLabel()
    private let ageLabel = AgeLabel()
    private let weightLabel = WeightLabel()
    private let heightLabel = HeightLabel()
    private let bmiLabel = BMILabel()
    private let bmiDescriptionLabel = BMIDescriptionLabel()
    
    //MARK: - UI Components
    
    private lazy var profileStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, genderLabel, ageLabel,
                                                   weightLabel, heightLabel, bmiLabel, bmiDescriptionLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        return stack
    }()
    //    MARK: - Lifecycle
    
    init(viewModel: ProfileViewModel) {
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
        setGradientBackground()
        fillName()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        fillName()
    }
}

private extension ProfileScreenViewController {
    
    func navigationBarAppearance() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonDidTapped))
        
        navigationItem.title = "My Profile"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = ColorResources.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonDidTapped() {
        router?.pushEditScreen()
    }
    
    
    func setupUI() {
        view.setupView(photoView)
        view.setupView(photoLabel)
        view.setupView(profileStackView)
    }
    
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            photoView.heightAnchor.constraint(equalToConstant: 140),
            photoView.widthAnchor.constraint(equalToConstant: 140),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            photoLabel.centerYAnchor.constraint(equalTo: photoView.centerYAnchor),
            photoLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            
            profileStackView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20),
            profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}

//MARK: - Gradient

extension ProfileScreenViewController {
    
    func fillName() {
        if let userID = UserDefaults.standard.string(forKey: "UserID") {
            if let userName = UserDefaults.standard.string(forKey: "UserName_ \(userID)") {
                nameLabel.text = "Name: \(userName)"
            }
        }
    }
    func setGradientBackground() {
        let topColor = ColorResources.gradientTopColor.cgColor
        
        let middleColor = ColorResources.gradientMiddleColor.cgColor
        
        let bottomColor = ColorResources.gradientBottomColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, middleColor, bottomColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
