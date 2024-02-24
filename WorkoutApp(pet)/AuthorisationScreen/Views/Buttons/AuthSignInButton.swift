//
//  AuthSignInButton.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 05.02.2024.
//

import UIKit

final class AuthSignInButton: UIButton {

    var signInTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        setupAction()
        makeSystem(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthSignInButton {
    func setupAppearence() {

        setTitle(Resources.AutorizedScreenStrings.signIn, for: .normal)
        layer.cornerRadius = 15
        backgroundColor = Resources.CommonColors.customCoral
    }

    @objc
    func signInDidTapped() {
        signInTapped?()
    }

    func setupAction() {
        addTarget(self, action: #selector(signInDidTapped), for: .touchUpInside)
    }
}
