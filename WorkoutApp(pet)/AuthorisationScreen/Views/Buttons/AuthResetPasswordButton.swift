//
//  AuthResetPasswordButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

final class AuthResetPasswordButton: UIButton {
    
    var resetTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupAction()
        setupLayout()
        makeSystem(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthResetPasswordButton {
    func setupAppearance() {
        
        setTitle(Const.resetPassword, for: .normal)
        setTitleColor(ColorResources.customBlue, for: .normal)
        backgroundColor = ColorResources.customDarkGrey
        layer.cornerRadius = 15
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 150),
            heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc
    func resetDidTapped() {
        resetTapped?()
    }
    
    func setupAction() {
        addTarget(self, action: #selector(resetDidTapped), for: .touchUpInside)
    }
}
