//
//  TrainNoteCell.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.03.2024.
//

//import UIKit
//import SwipeCellKit
//
//final class TrainNoteCell: SwipeCollectionViewCell {
//    
//    //MARK: - Variables
//    
//    var onDelete: (() -> Void)?
//    static let identifier = "CustomCollectionViewCell"
//    private let gradientLayer = CAGradientLayer()
//    
//    //MARK: - UI Components
//    
//    private let trainDayLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.textAlignment = .left
//        label.font = .systemFont(ofSize: 22)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let nameOfTrainLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 26, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let cellContentView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    //MARK: - Lifecycle
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setGradientBackground()
//        setupUI()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//
//    //MARK: - Cell Configure
//    
//    public func configure(with dayText: String, and nameText: String) {
//        self.trainDayLabel.text = dayText
//        self.nameOfTrainLabel.text = nameText
//        self.setupUI()
//    }
//    
//    
//    
//    
//    
//}
////MARK: - UI Setup
//private extension TrainNoteCell {
//    
//    func setupUI() {
//                
//        addSubview(contentView)
//        
//        contentView.addSubview(trainDayLabel)
//        contentView.addSubview(nameOfTrainLabel)
//        
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//        
//        NSLayoutConstraint.activate([
//            trainDayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//            trainDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
//
//            nameOfTrainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
//            nameOfTrainLabel.topAnchor.constraint(equalTo: trainDayLabel.bottomAnchor, constant: 5)
//        ])
//    }
//    
//
//}

import UIKit

class NoteCell: UICollectionViewCell {
    static let identifier = "NoteCell"
    private let gradientLayer = CAGradientLayer()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGradientBackground()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            self.titleLabel.text = nil
        }
    
    func setGradientBackground() {
        let firstColor = ColorResources.customCoral.cgColor
        
        let secondColor = ColorResources.white.withAlphaComponent(0.7).cgColor
        
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func configure(with note: Note) {
        titleLabel.text = note.title
    }
}

