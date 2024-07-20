//
//  AddNoteViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//

import UIKit

class AddNoteViewController: UIViewController {
    var viewModel: NotesViewModel
    
    private let categoryPicker = UISegmentedControl(items: [NoteCategory.sport.localizedName, NoteCategory.nutrition.localizedName, NoteCategory.others.localizedName])
    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    
    init(viewModel: NotesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    private func setupUI() {
        self.title = Const.newNote
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .font: FontResources.addExerciseLabelFont,
            .foregroundColor: ColorResources.white
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        view.backgroundColor = .purple
        
        view.addSubview(categoryPicker)
        view.addSubview(titleTextField)
        view.addSubview(contentTextView)

        titleTextField.placeholder = Const.title
        titleTextField.borderStyle = .roundedRect
        titleTextField.layer.cornerRadius = 10
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        contentTextView.layer.cornerRadius = 10
        contentTextView.translatesAutoresizingMaskIntoConstraints = false

        categoryPicker.selectedSegmentIndex = 0
        categoryPicker.layer.cornerRadius = 10
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            categoryPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryPicker.heightAnchor.constraint(equalToConstant: 40),

            titleTextField.topAnchor.constraint(equalTo: categoryPicker.bottomAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveNote() {
        guard let title = titleTextField.text, !title.isEmpty,
              let content = contentTextView.text, !content.isEmpty else { return }
        
        let selectedCategoryIndex = categoryPicker.selectedSegmentIndex
        let category: NoteCategory
        switch selectedCategoryIndex {
        case 0: category = .sport
        case 1: category = .nutrition
        case 2: category = .others
        default: category = .others
        }
        
        viewModel.addNote(title: title, content: content, category: category)
        navigationController?.popViewController(animated: true)
    }
}
