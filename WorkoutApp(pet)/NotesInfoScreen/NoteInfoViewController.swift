//
//  TrainNotesInfoViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 08.03.2024.
//

import UIKit

final class NoteInfoViewController: UIViewController {
    
    var note: Note?
    
    private let typeLabel = CustomDetailLabel(type: .type)
    private let titleLabel = CustomDetailLabel(type: .title)
    private let contentLabel = CustomDetailLabel(type: .content)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
        fillNoteData()
    }
}

private extension NoteInfoViewController {
    func setupUI() {
        setupViews(typeLabel, titleLabel, contentLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            typeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    func fillNoteData() {
        if let note = note {
            typeLabel.text = note.category.localizedName
            titleLabel.text = note.title
            contentLabel.text = note.content
        }
    }
}
