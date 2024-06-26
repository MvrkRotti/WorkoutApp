//
//  SignUpButton.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

final class SignUpButton: UIButton {
    
    var signUpTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupAction()
        makeSystem(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignUpButton {
    func setupAppearance() {
        
        setTitle(Const.signUp, for: .normal)
        setTitleColor(ColorResources.black, for: .normal)
        layer.cornerRadius = 15
        backgroundColor = ColorResources.customCoral
    }
    
    @objc func signUpDidTapped() {
        signUpTapped?()
    }
    
    func setupAction() {
        addTarget(self, action: #selector(signUpDidTapped), for: .touchUpInside)
    }
}



