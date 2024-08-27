//
//  TabBarSeparator.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.08.2024.
//

import UIKit

extension UIViewController {
    func addTabBarSeparator(color: UIColor = .lightGray, height: CGFloat = 1) {
        let tabBarSeparator = UIView()
        tabBarSeparator.translatesAutoresizingMaskIntoConstraints = false
        tabBarSeparator.backgroundColor = color
        
//        if let tabBar = self.tabBarController?.tabBar {
            view.addSubview(tabBarSeparator)
            
            NSLayoutConstraint.activate([
                tabBarSeparator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tabBarSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tabBarSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tabBarSeparator.heightAnchor.constraint(equalToConstant: height)
            ])
//        }
    }
}
