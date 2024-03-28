//
//  ActivityIndicator.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 28.03.2024.
//

import UIKit

final class CustomActivityIndicator: UIView {
    private let activityIndicator: UIActivityIndicatorView
    private let label: UILabel
    
    init(frame: CGRect, text: String) {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        
        label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18)
        
        super.init(frame: frame)
        
        setupView(activityIndicator)
        setupView(label)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
        label.isHidden = false
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        label.isHidden = true
    }
}
