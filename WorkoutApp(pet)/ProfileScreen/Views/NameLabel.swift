//
//  NameLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class NameLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NameLabel {
    func setupAppearence() {
        textColor = Resources.CommonColors.black
        font = Resources.CommonFonts.profileLabelFont
        text = "Name: "
    }
}
