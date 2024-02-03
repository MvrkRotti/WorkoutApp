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
        setupAppearence()
        setupAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SignInButton {
    func setupAppearence() {
        
        setTitle(Resources.autorizedScreen.signIn, for: .normal)
        setTitleColor(Resources.Colors.customOrange, for: .normal)
        let buttonTitleStr = NSMutableAttributedString(string: Resources.autorizedScreen.signIn)
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

//private let signInButton: UIButton = {
//    let button = UIButton()
//    button.setTitleColor(Resources.Colors.customOrange, for: .normal)
//    let buttonTitleStr = NSMutableAttributedString(string: Resources.autorizedScreen.signIn)
//    buttonTitleStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, buttonTitleStr.length))
//    button.setAttributedTitle(buttonTitleStr, for: .normal)
//    return button
//}()
