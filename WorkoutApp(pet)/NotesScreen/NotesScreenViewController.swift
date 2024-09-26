//
//  NotesViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

final class NotesScreenViewController: UIViewController, NotesViewModelDelegate {
    
    //MARK: - Variables
    
    private let router: Router
    private let viewModel: NotesViewModel
    
    private var notesCollectionView: UICollectionView!
    private let addButton = AddNoteButton()
    
    private var isCollectionViewSetup = false
    
    init(router: Router, viewModel: NotesViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchNotes()
        addTabBarSeparator()
        addNavigationBarSeparator()
        setupCollection()
        setupAddButton()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = ColorResources.white
        
        navBarSettingsWith(title: Const.notes)
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
        notesCollectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.identifier)
        notesCollectionView.register(NotesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NotesHeader.identifier)
        notesCollectionView.backgroundColor = .clear
        
        view.addSubview(notesCollectionView)
        
        isCollectionViewSetup = true
    }
    
    private func setupAddButton() {
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        addButton.addButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.router.navigateToAddNote(from: navigationController)
        }
        
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
    
    func didFailWithError(_ error: Error) {
        print("Failed to fetch notes: \(error.localizedDescription)")
        
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
        let note = viewModel.getNotes(for: category)[indexPath.row]
        cell.configure(with: note)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NotesHeader.identifier, for: indexPath) as! NotesHeader
        let category = NoteCategory.allCases[indexPath.section]
        headerView.titleLabel.text = category.localizedName
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ -> UIMenu? in
            guard let self = self else { return nil }
            
            let category = NoteCategory.allCases[indexPath.section]
            
            let notesForCategory = self.viewModel.getNotes(for: category)
            
            guard indexPath.item < notesForCategory.count else {
                return nil
            }
                        
            let deleteAction = UIAction(title: Const.delete, image: UIImage(systemName: "trash.fill"), attributes: .destructive) { [weak self] _ in
                guard let self = self else { return }
                
                self.viewModel.deleteNote(at: indexPath.item, category: category)
            }
            return UIMenu(title: "", children: [deleteAction])
        }
    }
}
