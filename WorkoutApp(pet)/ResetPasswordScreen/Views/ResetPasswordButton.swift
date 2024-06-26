//
//  ResetPasswordButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 18.04.2024.
//

import UIKit

final class ResetPasswordButton: UIButton {
    
    var resetTapped: (() -> Void)?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupLayout()
        setupAction()
        makeSystem(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension ResetPasswordButton {
    func setupAppearance() {
        setTitle(Const.resetPassword, for: .normal)
        setTitleColor(ColorResources.black, for: .normal)
        backgroundColor = ColorResources.customCoral
        layer.cornerRadius = 15
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 335),
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func resetDidTapped() {
        resetTapped?()
    }
    
    func setupAction() {
        addTarget(self, action: #selector(resetDidTapped), for: .touchUpInside)
    }
}

