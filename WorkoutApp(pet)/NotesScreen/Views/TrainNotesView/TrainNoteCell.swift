//
//  TrainNoteCell.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 06.03.2024.
//

import UIKit

final class TrainNoteCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifier = "CustomCollectionViewCell"
    let gradientLayer = CAGradientLayer()
    
    //MARK: - UI Components
    
    private let trainDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameOfTrainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.frame
        
    }
    //MARK: - Cell Configure
    
    public func configure(with dayText: String, and nameText: String) {
        self.trainDayLabel.text = dayText
        self.nameOfTrainLabel.text = nameText
        self.setupUI()
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.trainDayLabel.text = nil
        self.nameOfTrainLabel.text = nil
    }
    
}
//MARK: - UI Setup
private extension TrainNoteCell {
    
    func setupUI() {
        addSubview(trainDayLabel)
        addSubview(nameOfTrainLabel)
        
        NSLayoutConstraint.activate([
            trainDayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            trainDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            
            nameOfTrainLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameOfTrainLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setGradientBackground() {
        let firstColor = Resources.CommonColors.customCoral.cgColor
        
        let secondColor = Resources.CommonColors.white.withAlphaComponent(0.7).cgColor
        
        gradientLayer.colors = [firstColor, secondColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

