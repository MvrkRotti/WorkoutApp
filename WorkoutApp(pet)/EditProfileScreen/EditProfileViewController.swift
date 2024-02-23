//
//  EditProfileViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 23.02.2024.
//

import UIKit

final class EditProfileViewController: UIViewController {
    
    


    //MARK: - Variables
    var router: EditProfileScreenRouter!
    
    let profilePhoto = ProfilePhotoView(frame: CGRect())
    let ageTextField = AgeTextField()
    let weightTextField = WeightTextField()
    let heightTextField = HeightTextField()
    
        //MARK: - UI Components
    
    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ageTextField,weightTextField, heightTextField])
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    //MARK: - Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.customDarkGrey
        navigationBarAppearence()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            tabBarController?.tabBar.isHidden = true
        }
}

//MARK: - UI Setup

extension EditProfileViewController {
    func navigationBarAppearence() {
        let editButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)

        navigationItem.title = "Edit profile"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.Colors.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
        navigationItem.rightBarButtonItem = editButton
    }
    
    func setupUI() {
        view.setupView(profilePhoto)
        view.setupView(profileStack)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            profilePhoto.heightAnchor.constraint(equalToConstant: 140),
            profilePhoto.widthAnchor.constraint(equalToConstant: 140),
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            ageTextField.heightAnchor.constraint(equalToConstant: 44),
            ageTextField.widthAnchor.constraint(equalToConstant: 334),
            
            weightTextField.heightAnchor.constraint(equalToConstant: 44),
            weightTextField.widthAnchor.constraint(equalToConstant: 334),
            
            heightTextField.heightAnchor.constraint(equalToConstant: 44),
            heightTextField.widthAnchor.constraint(equalToConstant: 334),
            
            profileStack.topAnchor.constraint(equalTo: profilePhoto.bottomAnchor, constant: 35),
            profileStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
