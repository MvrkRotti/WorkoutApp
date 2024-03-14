//
//  TrainNotesView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.03.2024.
//

import UIKit

final class TrainNotesView: UIView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = Resources.CommonImages.trainNotesBackgoundImage
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        setupView(imageView)
        setupLayout()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TrainNotesView {
    func setupAppearence() {
        layer.cornerRadius = 15
        contentMode = .scaleAspectFit
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


