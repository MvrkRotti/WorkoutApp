//
//  SelectPhotoButton.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 24.02.2024.
//

import UIKit

final class SelectPhotoButton: UIButton {
    
    var selectPhotoTapped: (() -> Void)?
    
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

private extension SelectPhotoButton {
    func setupAppearence() {
        setTitle(Resources.CommonStrings.selectPhoto, for: .normal)
        setTitleColor(Resources.CommonColors.black, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.font = Resources.CommonFonts.autLabelFont
        sizeToFit()
        
        let buttonTitleStr = NSMutableAttributedString(string: Resources.CommonStrings.selectPhoto)
        buttonTitleStr.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, buttonTitleStr.length))
        
        setAttributedTitle(buttonTitleStr, for: .normal)
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    @objc
    func selectPhotoDidTapped() {
        selectPhotoTapped?()
    }
    
    func setupAction() {
        addTarget(self, action: #selector(selectPhotoDidTapped), for: .touchUpInside)
    }
}