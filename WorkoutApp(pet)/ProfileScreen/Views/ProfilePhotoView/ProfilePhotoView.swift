//
//  ProfilePhotoView.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class ProfilePhotoView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProfilePhotoView {
    func setupAppearance() {
        contentMode = .scaleAspectFit
        backgroundColor = ColorResources.customGray
        layer.borderWidth = 1.5
        layer.borderColor = ColorResources.customDarkGrey.cgColor
        layer.cornerRadius = 140 / 2
    }
}
