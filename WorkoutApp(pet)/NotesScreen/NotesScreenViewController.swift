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
    var router: NotesRouter
    private var viewModel: NotesViewModel
    
    private let trainViewLabel = TrainViewLabel()
    private let trainCollectionView = TrainCollectionView()
    private let addNoteButton = AddNoteButton()
    
    //MARK: - Lifecycle
    
    init(_ viewModel: NotesViewModel, router: NotesRouter) {
        self.viewModel = viewModel
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
        setDelegates()
        setupAction()
        navigationBarAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trainCollectionView.reloadData()
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
}
//MARK: - NavBar appearance

extension NotesScreenViewController {
    
    func navigationBarAppearance() {
        navigationController?.navigationBar.barTintColor = ColorResources.customDarkGrey
        navigationController?.navigationBar.alpha = 0.9
        navigationController?.navigationBar.topItem?.title = StringResources.NavigationBarHeaders.notesScreen
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
        view.setupView(addNoteButton)
        trainCollectionView.setupView(trainViewLabel)
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            trainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            trainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            trainViewLabel.topAnchor.constraint(equalTo: trainCollectionView.topAnchor, constant: 15),
            trainViewLabel.leadingAnchor.constraint(equalTo: trainCollectionView.leadingAnchor, constant: 20),
            
            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNoteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addNoteButton.heightAnchor.constraint(equalToConstant: 65),
            addNoteButton.widthAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setupAction() {
        addNoteButton.addButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.router.pushNextScreen(on: self, delegate: self)
        }
    }
    
}

//MARK: - UICollectionView Delegate and Data Source

extension NotesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getAllNotes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrainNoteCell.identifier,
                for: indexPath) as? TrainNoteCell
        else { fatalError("Failed to dequeue CustomCollectionViewCell in viewController")
        }
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        let day = viewModel.getAllNotes()[indexPath.row].trainName
        let name = viewModel.getAllNotes()[indexPath.row].kindOfMuscle
        cell.configure(with: day, and: name)
        
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
        let heightSize = (view.frame.height / 8)
        
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

extension NotesScreenViewController: AddNoteDelegate {
    func didAddNote(_ note: ExerciseNote) {
        viewModel.addNote(note)
        trainCollectionView.reloadData()
    }
    
    
}

