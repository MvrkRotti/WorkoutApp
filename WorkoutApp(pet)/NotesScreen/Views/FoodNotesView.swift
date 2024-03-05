//
//  FoodNotesView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.03.2024.
//

import UIKit

final class FoodNotesView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FoodNotesView {
    func setupAppearence() {
        image = Resources.CommonImages.foodNotesBackgoundImage
        contentMode = .scaleAspectFill
        layer.cornerRadius = 15
    }
}
