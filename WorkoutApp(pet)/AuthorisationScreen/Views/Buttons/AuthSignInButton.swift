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
        setupAppearance()
        setupAction()
        makeSystem(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AuthSignInButton {
    func setupAppearance() {

        setTitle(Const.sighIn, for: .normal)
        setTitleColor(ColorResources.black, for: .normal)
        layer.cornerRadius = 15
        backgroundColor = ColorResources.customCoral
    }

    @objc
    func signInDidTapped() {
        signInTapped?()
    }

    func setupAction() {
        addTarget(self, action: #selector(signInDidTapped), for: .touchUpInside)
    }
}
