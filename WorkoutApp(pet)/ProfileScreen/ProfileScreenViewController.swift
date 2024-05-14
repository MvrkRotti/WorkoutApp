//
//  ProfileScreenViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit
//import SDWebImage

final class ProfileScreenViewController: UIViewController {
    
    //MARK: - Variables
    
    var router: ProfileRouterProtocol?
    var viewModel: ProfileViewModel
    
    private let photoView = ProfilePhotoView(frame: .zero)
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
                                                   weightLabel, heightLabel,
                                                   bmiLabel, bmiDescriptionLabel])
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
        fillProfileData()
        loadProfilePhoto()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        fillProfileData()
        loadProfilePhoto()
    }
}

//MARK: - NavBar Settings
private extension ProfileScreenViewController {
    
    func navigationBarAppearance() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonDidTapped))
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonDidTapped))
        
        navigationItem.title = "My Profile"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = ColorResources.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
        navigationItem.rightBarButtonItem = editButton
        navigationItem.leftBarButtonItem = logOutButton
        navigationItem.leftBarButtonItem?.tintColor = .red
    }
    
    @objc func editButtonDidTapped() {
        router?.pushEditScreen()
    }
    
    @objc func logOutButtonDidTapped() {
        router?.popToRoot(form: self)
    }
    
    
    func setupUI() {
        view.setupView(photoView)
        view.setupView(profileStackView)
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

//MARK: - Profile filling
extension ProfileScreenViewController {
    
    func fillProfileData() {
        if let name = viewModel.name {
            nameLabel.text = "Name: \(name)"
        }
        if let age = viewModel.age {
            ageLabel.text = "Age: \(age) years"
        }
        if let weight = viewModel.weight {
            weightLabel.text = "Weight: \(weight) kg"
        }
        if let height = viewModel.height {
            heightLabel.text = "Height: \(height) cm"
        }
        if let gender = viewModel.gender {
            genderLabel.text = "Gender: \(gender)"
        }
        
        if let bmi = viewModel.bmi {
            let roundedBMI = String(format: "%.2f", bmi) // Округляем до 2 знаков после запятой
            bmiLabel.text = "BMI: \(roundedBMI)"
        }
        
        if let bmiDescription = viewModel.bmiDescription {
            bmiDescriptionLabel.text = "\(bmiDescription)"
            bmiDescriptionLabel.textColor = viewModel.textColor
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
