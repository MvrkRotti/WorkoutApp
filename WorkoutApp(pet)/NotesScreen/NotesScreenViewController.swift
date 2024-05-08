//
//  NotesViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit
import SwipeCellKit

final class NotesScreenViewController: UIViewController {
    
    //MARK: - Variables
    
    let networkService = NetworkService()
    var router: NotesRouter
    private var viewModel: NotesViewModel
    
    private let trainViewLabel = TrainViewLabel()
    private let trainCollectionView = TrainCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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
        loadNotes()
    
        
        viewModel.onDeleteNote = { [weak self] indexPath in
            self?.trainCollectionView.deleteItems(at: [indexPath])
        }
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
    
    private func loadNotes() {
        viewModel.getAllNotes()
    }
    
    private func setDelegates() {
        trainCollectionView.delegate = self
        trainCollectionView.dataSource = self
    }
    //MARK: - UI Setup
    
    func setupUI() {
        
        view.setupView(trainCollectionView)
        view.setupView(addNoteButton)
        trainCollectionView.setupView(trainViewLabel)
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            trainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
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
        //        return viewModel.getAllNotes().count
        return viewModel.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrainNoteCell.identifier,
                for: indexPath) as? TrainNoteCell
        else { fatalError("Failed to dequeue CustomCollectionViewCell in viewController")
        }
        cell.delegate = self
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        //        let day = viewModel.getAllNotes()[indexPath.row].trainName
        //        let name = viewModel.getAllNotes()[indexPath.row].kindOfMuscle
        
        let day = viewModel.notes[indexPath.row].trainName
        let name = viewModel.notes[indexPath.row].kindOfMuscle
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

//MARK: - Collection view appearence settings
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
    
//    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
}

extension NotesScreenViewController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Remove") { action, indexPath in
            self.viewModel.deleteNote(at: indexPath)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.textColor = .black
        deleteAction.image = UIImage(systemName: "trash")
        
        return [deleteAction]
    }
//
//    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .drag
//        return options
//    }
}

extension NotesScreenViewController: AddNoteDelegate {
    func didAddNote(_ note: ExerciseNote) {
        viewModel.addNote(note.trainName, note.kindOfMuscle)
        trainCollectionView.reloadData()
    }
}

