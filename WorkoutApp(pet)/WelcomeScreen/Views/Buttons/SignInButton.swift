//
//  SignInButton.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit

final class SignInButton: UIButton {
    
    var signInTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        setupAppearance()
        setupAction()
        makeSystem(self)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignInButton {
    func setupAppearance() {
        
        setTitle(Const.sighIn, for: .normal)
        setTitleColor(ColorResources.white, for: .normal)
        titleLabel?.font = FontResources.systemFont15
        let buttonTitleStr = NSMutableAttributedString(string: Const.sighIn)
        buttonTitleStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, buttonTitleStr.length))
        setAttributedTitle(buttonTitleStr, for: .normal)

        
    }
    
    @objc
    func signUpDidTapped() {
        signInTapped?()
    }
    
    func setupAction() {
        addTarget(self, action: #selector(signUpDidTapped), for: .touchUpInside)
    }
}

