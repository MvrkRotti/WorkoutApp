//
//  ExerciseCell.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

final class ExerciseCell: UITableViewCell {
    
    static let identifier = "ExerciseCell"
    
    //MARK: - Variables
    
    private(set) var exercise: Exercise!
    
    //MARK: - UI Components
    
    private let cellView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = Resources.Colors.customCoral
        return view
    }()
    private let cellNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.customGrey
        label.textAlignment = .left
        label.font = Resources.Fonts.cellNameLabelFont
        label.text = "Error"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with exercise: Exercise) {
        self.exercise = exercise
        
        self.cellNameLabel.text = exercise.type.uppercased()
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellNameLabel.text = nil
    }
    
    //MARK: - UI Setup

    private func setupUI() {
        self.setupView(cellView)
        cellView.setupView(cellNameLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cellView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.95),
            cellView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
//            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            cellNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 25),
            cellNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
    }
}
