//
//  NotesViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit
import SwipeCellKit

final class NotesScreenViewController: UIViewController, NotesViewModelDelegate {
    
    //MARK: - Variables
    
    private let router: NotesRouter
    private let viewModel: NotesViewModel
    
    private var notesCollectionView: UICollectionView!
    private let addButton = UIButton()
    
    init(router: NotesRouter, viewModel: NotesViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backGroundImage")!)
        viewModel.delegate = self
        setupCollection()
        setupAddButton()
    }
    
    private func setupUI() {
        self.title = "Notes"
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 100)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 50)
        
        notesCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        notesCollectionView.delegate = self
        notesCollectionView.dataSource = self
        notesCollectionView.register(NoteCell.self, forCellWithReuseIdentifier: "noteCell")
        notesCollectionView.register(NotesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        notesCollectionView.backgroundColor = .clear
        
        view.addSubview(notesCollectionView)
    }
    
    private func setupAddButton() {
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.backgroundColor = ColorResources.customCoral
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 30
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        addButton.layer.shadowRadius = 5
        addButton.addTarget(self, action: #selector(addNoteTapped), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func notesDidChange() {
        DispatchQueue.main.async {
            self.notesCollectionView.reloadData()
        }
    }
    
    @objc private func addNoteTapped() {
        let addVC = AddNoteViewController()
        router.pushNextScreen(on: addVC)
    }
}

extension NotesScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return NoteCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = NoteCategory.allCases[section]
        return viewModel.notes.filter { $0.category == category }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.identifier, for: indexPath) as! NoteCell
        let category = NoteCategory.allCases[indexPath.section]
        let notes = viewModel.notes.filter { $0.category == category }
        let note = notes[indexPath.row]
        cell.configure(with: note)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NotesHeader.identifier, for: indexPath) as! NotesHeader
        headerView.titleLabel.text = NoteCategory.allCases[indexPath.section].rawValue
        return headerView
    }
}
