//
//  NotesViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

final class NotesScreenViewController: UIViewController {
    //MARK: - Variables
    
    let trainNote = ["1 DAY: Chest and triceps",
                     "2 DAY: Back and biceps",
                     "3 DAY: Legs and shoulders",
                     "Home: Yoga"]
    
    let foodNote = ["Breakfast", "lunch", "Snack", "Dinner"]
    
    private let trainView = TrainNotesView()
    private let trainViewLabel = TrainViewLabel()
    private let trainCollectionView = TrainCollectionView()
    
    private let foodView = FoodNotesView()
    private let foodViewLabel = FoodViewLabel()
    private let foodCollectionView = FoodCollectionView()
    
    
    //MARK: - UIElements
    
    private lazy var viewsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [trainView, foodView])
        stack.axis = .vertical
        stack.spacing = 15
        //        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
        setupUI()
        setupLayout()
        setDelegates()
    }
    
}

extension NotesScreenViewController {
    
    func navigationBarAppearence() {
        navigationItem.title = "My Notes"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.CommonColors.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
    }
    //MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = Resources.CommonColors.customDarkGrey
        trainCollectionView.backgroundColor = UIColor.clear
        foodCollectionView.backgroundColor = UIColor.clear
        
        view.setupView(viewsStack)
        
        trainView.setupView(trainViewLabel)
        trainView.setupView(trainCollectionView)
        
        foodView.setupView(foodViewLabel)
        foodView.setupView(foodCollectionView)
        
    }
    
    //MARK: - Set Delegates
    
    private func setDelegates() {
        trainCollectionView.delegate = self
        trainCollectionView.dataSource = self
        
        foodCollectionView.delegate = self
        foodCollectionView.dataSource = self
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            
            viewsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewsStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            trainViewLabel.topAnchor.constraint(equalTo: trainView.topAnchor, constant: 10),
            trainViewLabel.leadingAnchor.constraint(equalTo: trainView.leadingAnchor, constant: 20),
            
            trainCollectionView.topAnchor.constraint(equalTo: trainViewLabel.bottomAnchor),
            trainCollectionView.leadingAnchor.constraint(equalTo: trainView.leadingAnchor),
            trainCollectionView.trailingAnchor.constraint(equalTo: trainView.trailingAnchor),
            trainCollectionView.bottomAnchor.constraint(equalTo: trainView.bottomAnchor, constant: -10),
            
            foodViewLabel.topAnchor.constraint(equalTo: foodView.topAnchor, constant: 10),
            foodViewLabel.leadingAnchor.constraint(equalTo: foodView.leadingAnchor, constant: 20),
            
            foodCollectionView.topAnchor.constraint(equalTo: foodViewLabel.bottomAnchor),
            foodCollectionView.leadingAnchor.constraint(equalTo: foodView.leadingAnchor),
            foodCollectionView.trailingAnchor.constraint(equalTo: foodView.trailingAnchor),
            foodCollectionView.bottomAnchor.constraint(equalTo: foodView.bottomAnchor, constant: -10),
        ])
    }
}

extension NotesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trainCollectionView {
            return trainNote.count
        } else {
            return foodNote.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trainCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrainNoteCell.identifier,
                    for: indexPath) as? TrainNoteCell
            else { fatalError("Failed to dequeue CustomCollectionViewCell in viewController")
            }
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            let item = self.trainNote[indexPath.row]
            cell.configure(with: item)
            
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodNoteCell.identifier,
                    for: indexPath) as? FoodNoteCell
            else { fatalError("Failed to dequeue CustomCollectionViewCell in viewController")
            }
            cell.layer.cornerRadius = 15
            cell.layer.masksToBounds = true
            let item = self.foodNote[indexPath.row]
            cell.configure(with: item)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TrainNotesInfoViewController()
        present(vc, animated: true, completion: nil)
    }
}

extension NotesScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = (trainView.frame.width) - 40
        let heightSize = (trainView.frame.height/7)
        
        return CGSize(width: widthSize, height: heightSize)
    }
    
    //Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    //    //Horizontal spacing
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return 20
    //    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.trainView.frame.width, height: 10)
    }
}

