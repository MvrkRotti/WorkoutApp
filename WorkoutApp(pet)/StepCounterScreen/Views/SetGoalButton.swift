//
//  setGoalButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit

final class SetGoalButton: UIButton {
    
    var buttonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        setupAction()
        makeSystem(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearence() {
        backgroundColor = ColorResources.customBlue
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(Const.dailyGoalButtonTitle, for: .normal)
        setTitleColor(ColorResources.white, for: .normal)
        
    }
    
    private func setupAction() {
        addTarget(self, action: #selector(setGoalTapped), for: .touchUpInside)
    }
    
    @objc func setGoalTapped() {
        buttonTapped?()
    }
}




