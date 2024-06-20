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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}

private extension ProfilePhotoView {
    func setupAppearance() {
        contentMode = .scaleAspectFill
        backgroundColor = ColorResources.customGray
        layer.borderWidth = 1.5
        layer.borderColor = ColorResources.customDarkGrey.cgColor
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
    }
    

}
