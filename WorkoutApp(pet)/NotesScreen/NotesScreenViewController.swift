//
//  NotesViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

final class NotesScreenViewController: UIViewController {
    //MARK: - Variables
    
    let networkService = NetworkService()
    
    private let maleTrainNote = [
        "1 DAY:": "Chest and triceps",
        "2 DAY:": "Back and biceps",
        "3 DAY:": "Legs and shoulders",
        "Home:": "Yoga"].sorted(by: <)

    private let femaleTrainNote = [
        "3 DAY:": "Test",
        "4 DAY:": "Test",
        "5 DAY:": "Legs and shoulders"].sorted(by: <)
    
    private let segmentedController = TrainSegmentedController(items: ["Male", "Female"])
    
    private let trainViewLabel = TrainViewLabel()
    private let trainCollectionView = TrainCollectionView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarAppearence()
        setupUI()
        setupLayout()
        setDelegates()
    }
    
}
//MARK: - NavBar appearence

extension NotesScreenViewController {
    
    
    func navigationBarAppearence() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = Resources.CommonColors.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
        navigationItem.titleView = segmentedController
    }
    
    //MARK: - Set Delegates
    
    private func setDelegates() {
        trainCollectionView.delegate = self
        trainCollectionView.dataSource = self
    }
    //MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = UIColor(
            patternImage: UIImage(named: "backGroundImage")!)
        
        view.setupView(trainCollectionView)
        trainCollectionView.setupView(trainViewLabel)
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([            
            trainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            trainViewLabel.topAnchor.constraint(equalTo: trainCollectionView.topAnchor, constant: 15),
            trainViewLabel.leadingAnchor.constraint(equalTo: trainCollectionView.leadingAnchor, constant: 20)
        ])
    }
}

//MARK: - UICollectionView Delegate and Data Source

extension NotesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedController.selectedSegmentIndex == 0 {
            return maleTrainNote.count
            
        } else {
            return femaleTrainNote.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrainNoteCell.identifier,
                for: indexPath) as? TrainNoteCell
        else { fatalError("Failed to dequeue CustomCollectionViewCell in viewController")
        }
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        if segmentedController.selectedSegmentIndex == 0 {
            let day = String(Array(maleTrainNote)[indexPath.row].key)
            let name = String(Array(maleTrainNote)[indexPath.row].value)
            cell.configure(with: day, and: name)
        } else if segmentedController.selectedSegmentIndex == 1 {
            let day = String(Array(femaleTrainNote)[indexPath.row].key)
            let name = String(Array(femaleTrainNote)[indexPath.row].value)
            cell.configure(with: day, and: name)
        }
        cell.contentView.layer.cornerRadius = 15
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TrainNotesInfoViewController()
        present(vc, animated: true, completion: nil)
    }
}

extension NotesScreenViewController: UICollectionViewDelegateFlowLayout {
    
    //Setup size for cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSize = (view.frame.width) - 40
        let heightSize = (view.frame.height/6)
        
        return CGSize(width: widthSize, height: heightSize)
    }
    
    //Vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    //Setup header space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }
}

