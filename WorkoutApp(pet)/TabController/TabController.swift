//
//  TabController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//



import UIKit

enum Tabs: Int, CaseIterable {
    case exercises
    case notes
    case profile
}

final class TabController: UITabBarController {

    var router: TabRouter!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configureAppearance()
        switchTo(tab: .notes)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }

    func switchTo(tab: Tabs) {
        selectedIndex = tab.rawValue
    }

    private func configureAppearance() {
        tabBar.tintColor = Resources.CommonColors.customCoral
        tabBar.unselectedItemTintColor = Resources.CommonColors.white
        tabBar.barTintColor = Resources.CommonColors.customDarkGrey
        tabBar.layer.masksToBounds = true
        tabBar.alpha = 0.9
        
        let controllers: [UIViewController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: Resources.TabBar.title(for: tab),
                                                 image: Resources.TabBar.icon(for: tab),
                                                 tag: tab.rawValue)
            return controller
        }

        setViewControllers(controllers, animated: false)
    }

    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .exercises: return ExerciseScreenViewController()
        case .notes: return NotesScreenViewController()
        case .profile: return ProfileScreenViewController()
        }
    }
}
