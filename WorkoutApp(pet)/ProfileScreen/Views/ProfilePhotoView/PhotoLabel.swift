//
//  PhotoTitle.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class PhotoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PhotoLabel {
    func setupAppearence() {
        textColor = Resources.Colors.black
        font = Resources.Fonts.autLabelFont
        numberOfLines = 0
        textAlignment = .center
        text = "Your\nPhoto"
    }
} 
