//
//  ProfileScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit
import FirebaseAuth

final class ProfileScreenViewController: UIViewController {
    
    //MARK: - Variables
    
    var router: DefaultRouter
    var viewModel: ProfileViewModel
    
    private let photoView = ProfilePhotoView(frame: .zero)
    private let nameLabel = NameLabel()
    private let genderLabel = GenderLabel()
    private let ageLabel = AgeLabel()
    private let weightLabel = WeightLabel()
    private let heightLabel = HeightLabel()
    private let bmiLabel = BMILabel()
    private let bmiDescriptionLabel = BMIDescriptionLabel()
    private let backBarButton = CustomNavBarButton(type: .system)
    private let editBarButton = CustomNavBarButton(type: .system)
    
    //MARK: - UI Components
    
    private lazy var profileStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, genderLabel, ageLabel,
                                                   weightLabel, heightLabel,
                                                   bmiLabel, bmiDescriptionLabel])
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        return stack
    }()
    //    MARK: - Lifecycle
    
    init(viewModel: ProfileViewModel, router: DefaultRouter) {
        self.viewModel = viewModel
        self.router = router
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
        fillProfile()
        loadProfilePhoto()
        
        viewModel.didLogout = { [weak self] in
                    self?.handleLogout()
                }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        fillProfile()
        loadProfilePhoto()
    }
}

//MARK: - NavBar Settings
private extension ProfileScreenViewController {
    
    func navigationBarAppearance() {
        let logOutButton = UIBarButtonItem(customView: backBarButton)
        backBarButton.setTitle(Const.logOut, for: .normal)
        backBarButton.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        backBarButton.addTarget(self, action: #selector(logOutButtonDidTapped), for: .touchUpInside)
        backBarButton.tintColor = ColorResources.customRed
        
        let editButton = UIBarButtonItem(customView: editBarButton)
        editBarButton.setTitle(Const.edit, for: .normal)
        editBarButton.frame = CGRect(x: 0, y: 0, width: 90, height: 20)
        editBarButton.addTarget(self, action: #selector(editButtonDidTapped), for: .touchUpInside)
        
        navigationItem.title = Const.myProfile
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.backgroundColor = ColorResources.customDarkGrey
        navigationItem.leftBarButtonItem = logOutButton
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonDidTapped() {
        router.navigateToEditScreen(from: navigationController)
    }
    
    @objc func logOutButtonDidTapped() {
        viewModel.logout()
    }
    
    private func handleLogout() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let welcomeViewController = sceneDelegate.assembler.resolve() as WelcomeViewController
            router.setRootViewController(welcomeViewController, in: sceneDelegate.window!)
        }
    }

    func setupUI() {
        view.setupView(photoView)
        view.setupView(profileStackView)
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: FontResources.boldSystemFont20,
            .foregroundColor: ColorResources.white
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            photoView.heightAnchor.constraint(equalToConstant: 140),
            photoView.widthAnchor.constraint(equalToConstant: 140),
            photoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            profileStackView.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 20),
            profileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - Profile filling

private extension ProfileScreenViewController {
    
    func setProfileData() {
        
        nameLabel.text = Const.firstName + ": " + (viewModel.name ?? Const.noName)
        ageLabel.text = viewModel.age != nil ? Const.age + ": " + "\(viewModel.age!)" : Const.noAge
        weightLabel.text = viewModel.weight != nil ? Const.weight + ": " + "\(viewModel.weight!)" + Const.kg : Const.noWeight
        heightLabel.text = viewModel.height != nil ? Const.height + ": " + "\(viewModel.height!)" + Const.cm : Const.noHeight
        genderLabel.text = Const.gender + ": " + (viewModel.gender ?? Const.noGender)
        
        if let bmi = viewModel.bmi {
            let roundedBMI = String(format: "%.2f", bmi) // Округляем до 2 знаков после запятой
            bmiLabel.text = Const.BMI + String(roundedBMI)
        }
        
        if let bmiDescription = viewModel.bmiDescription {
            bmiDescriptionLabel.text = "\(bmiDescription)"
            bmiDescriptionLabel.textColor = viewModel.textColor
        }
    }
    
    func fillProfile() {
        viewModel.fetchUserProfile { [weak self] user, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showAlert(message: "Error: \(error)")
                } else {
                    self?.setProfileData()
                }
            }
        }
    }
    
    func loadProfilePhoto() {
        FetchProfilePhoto.fetchProfileImage { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let image = image {
                    self.photoView.image = image
                } else {
                    return
                }
            }
        }
    }
    
    //MARK: - Gradient
    
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
