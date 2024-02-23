//
//  TabController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

//import UIKit
//
//class TabController: UITabBarController {
//
//    var router: TabRouter!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTabs()
//        setupTabBarAppearence()
//    }
//}
//
//private extension TabController {
//
//    private func setupTabBarAppearence() {
//        tabBar.barTintColor = Resources.Colors.customGrey
//        tabBar.tintColor = Resources.TextField.Colors.borderColor
//        tabBar.unselectedItemTintColor = Resources.Colors.customWhite
//        tabBar.alpha = 0.9
//    }
//
//    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
//        let nav = UINavigationController(rootViewController: vc)
//        nav.tabBarItem.title = title
//        nav.tabBarItem.image = image
//        nav.viewControllers.first?.navigationItem.title = title
//        return nav
//    }
//
//    private func setupTabs() {
//
//        let home = self.createNav(
//            with: Resources.TabBar.TabBarHeaders.homeHeader,
//            and: Resources.TabBar.TabBarIcons.homeIcon,
//            vc: HomeScreenViewController())
//
//        let progress = self.createNav(
//            with: Resources.TabBar.TabBarHeaders.progressHeader,
//            and: Resources.TabBar.TabBarIcons.profileIcon,
//            vc: ProfileScreenViewController())
//
//        let notes = self.createNav(
//            with: Resources.TabBar.TabBarHeaders.notesHeader,
//            and: Resources.TabBar.TabBarIcons.notesIcon,
//            vc: NotesScreenViewController())
//
//        let profile = self.createNav(
//            with: Resources.TabBar.TabBarHeaders.profileHeader,
//            and: Resources.TabBar.TabBarIcons.profileIcon,
//            vc: ProfileScreenViewController())
//
//        self.setViewControllers([home, progress, notes, profile], animated: true)
//    }
//}

import UIKit

enum Tabs: Int, CaseIterable {
    case home
//    case progress
    case notes
    case profile
}

final class TabController: UITabBarController {
    
    var router: TabRouter!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        configureAppearance()
        switchTo(tab: .profile)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }
    
    

    func switchTo(tab: Tabs) {
        selectedIndex = tab.rawValue
    }

    private func configureAppearance() {
        tabBar.tintColor = Resources.Colors.customCoral
        tabBar.unselectedItemTintColor = Resources.Colors.white
        tabBar.barTintColor = Resources.Colors.customDarkGrey
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
        case .home: return HomeScreenViewController()
//        case .progress: return ProgressScreenViewController()
        case .notes: return NotesScreenViewController()
        case .profile: return ProfileScreenViewController()
        }
    }
}
