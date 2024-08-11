//
//  ResetLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

final class ResetLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ResetLabel {
    func setupAppearance() {
        text = Const.resetPasswordInfo
        font = FontResources.systemFont18
        numberOfLines = 0
        textColor = ColorResources.black
        textAlignment = .center
    }
}
