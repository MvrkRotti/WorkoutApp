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
    var isImageSelected = false
    var imageURL: String?
    
    private let photoView = ProfilePhotoView(frame: .zero)
    //    private let photoLabel = PhotoLabel()
    private let imagePicker = UIImagePickerController()
    private let nameLabel = NameLabel()
    private let photoLabel = SelectPhotoButton()
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
        loadImage()
        setupTarget()
        
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
        fillProfileData()
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
    
    func setupTarget() {
        photoLabel.addTarget(self, action: #selector(addPhotoDidTapped), for: .touchUpInside)
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

extension ProfileScreenViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc func addPhotoDidTapped() {
        if !isImageSelected { // Проверяем, выбрано ли уже изображение
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image selected")
            return
        }
        
        // Загрузка изображения в Firebase Storage
        viewModel.uploadImage(image: image) { [weak self] imageURL in
            guard let imageURL = imageURL else { return }
            self?.viewModel.saveImageURL(imageURL) // Сохранение URL загруженного изображения
            self?.updateImageView(with: imageURL)
        }
    }
    
    func updateImageView(with imageURL: String) {
        guard let url = URL(string: imageURL) else {
            print("Invalid URL")
            return
        }
        // Загрузка изображения из URL
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    let scaledImage = ImageScaler.scaleImage(image, toFit: self?.photoView.bounds.size ?? CGSize.zero)
                    self?.photoView.image = scaledImage
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func loadImage() {
        if let savedImageURL = UserDefaults.standard.string(forKey: "imageURL") {
            imageURL = savedImageURL
            updateImageView(with: savedImageURL)
        }
    }
}

