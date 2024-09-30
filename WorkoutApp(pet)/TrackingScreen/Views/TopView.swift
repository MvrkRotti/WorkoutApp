//
//  TopView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 28.09.2024.
//

import Foundation
import UIKit

final class TopView: UIView {
    private let totalTimeLabel = UILabel()
    private let distanceLabel = UILabel()
    private let caloriesLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        setupFontsFor(labels: [totalTimeLabel, distanceLabel, caloriesLabel])
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(totalTimeLabel)
        addSubview(distanceLabel)
        addSubview(caloriesLabel)
        
        totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalTimeLabel.text = "00:00:00 \nTotal time"
        distanceLabel.text = "0.00 \nDistance (km)"
        caloriesLabel.text = "0 \nCalories(kcal)"
    }
        
    private func setupLayout() {
        NSLayoutConstraint.activate([
            totalTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalTimeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            caloriesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            caloriesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])
    }
    
    private func setupFontsFor(labels: [UILabel]) {
        labels.forEach { label in
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            label.textAlignment = .center
            label.numberOfLines = 0
        }
    }
    
    func updateMetrics(distance: Double, time: String, calories: Double) {
        distanceLabel.text = String(format: "Дистанция: %.2f м", distance)
        totalTimeLabel.text = "Время: \(time)"
        caloriesLabel.text = String(format: "Калории: %.2f", calories)
    }
}
