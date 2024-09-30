//
//  CustomDetailLabels.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 30.09.2024.
//

import Foundation
import UIKit

enum LabelType {
    case type
    case title
    case content
}

final class CustomDetailLabel: UILabel {
    init(type: LabelType) {
        super.init(frame: .zero)
        configureLabelsWith(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomDetailLabel {
    func configureLabelsWith(type: LabelType) {
        switch type {
        case .type:
            font = UIFont.systemFont(ofSize: 25, weight: .bold)
            textAlignment = .center
        case .title:
            font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            textAlignment = .center
            numberOfLines = 0
        case .content:
            font = UIFont.systemFont(ofSize: 18, weight: .regular)
            numberOfLines = 0
        }
        textColor = ColorResources.black
    }
}
