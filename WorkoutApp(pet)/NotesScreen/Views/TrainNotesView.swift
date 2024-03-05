//
//  TrainNotesView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.03.2024.
//

import UIKit

final class TrainNotesView: UIImageView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TrainNotesView {
    func setupAppearence() {
        image = Resources.CommonImages.trainNotesBackgoundImage
        contentMode = .scaleAspectFill
        layer.cornerRadius = 15
    }
    
}


