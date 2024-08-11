//
//  TabController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case stats
    case notes
    case profile
}

final class TabController: UITabBarController {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
        super.init(nibName: nil, bundle: nil)
        configureAppearance()
        switchTo(tab: .stats)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }

    func switchTo(tab: Tabs) {
        selectedIndex = tab.rawValue
    }

    private func configureAppearance() {
        tabBar.tintColor = ColorResources.customBlue
        tabBar.unselectedItemTintColor = ColorResources.black
        tabBar.barTintColor = ColorResources.white
        tabBar.layer.masksToBounds = true
        tabBar.alpha = 0.9
        
        let controllers: [UIViewController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: "",
                                                 image: tabIcon(for: tab),
                                                 tag: tab.rawValue)
            return controller
        }

        setViewControllers(controllers, animated: false)
    }

    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .stats: return assembler.resolve() as StepCounterViewController
        case .notes: return assembler.resolve() as NotesScreenViewController
        case .profile: return assembler.resolve() as ProfileScreenViewController
        }
    }

    private func tabTitle(for tab: Tabs) -> String {
        switch tab {
        case .stats: return Const.handbook
        case .notes: return Const.notes
        case .profile: return Const.profile
        }
    }

    private func tabIcon(for tab: Tabs) -> UIImage? {
        switch tab {
        case .stats: return UIImage(named: "statIcon")
        case .notes: return UIImage(named: "notesIcon")
        case .profile: return UIImage(named: "profileIcon")
        }
    }
}
