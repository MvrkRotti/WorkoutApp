//
//  TabController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 06.02.2024.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearence()
    }
}

private extension TabController {
    
    private func setupTabBarAppearence() {
        tabBar.barTintColor = Resources.Colors.customGrey
        tabBar.tintColor = Resources.TextField.Colors.borderColor
        tabBar.unselectedItemTintColor = Resources.Colors.customWhite
        tabBar.alpha = 0.9
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    private func setupTabs() {
                
        let home = self.createNav(
            with: Resources.TabBar.TabBarHeaders.homeHeader,
            and: Resources.TabBar.TabBarIcons.homeIcon,
            vc: HomeScreenViewController())
        
        let progress = self.createNav(
            with: Resources.TabBar.TabBarHeaders.progressHeader,
            and: Resources.TabBar.TabBarIcons.profileIcon,
            vc: HomeScreenViewController())
        
        let notes = self.createNav(
            with: Resources.TabBar.TabBarHeaders.notesHeader,
            and: Resources.TabBar.TabBarIcons.notesIcon,
            vc: HomeScreenViewController())
        
        let profile = self.createNav(
            with: Resources.TabBar.TabBarHeaders.profileHeader,
            and: Resources.TabBar.TabBarIcons.profileIcon,
            vc: HomeScreenViewController())
        
        self.setViewControllers([home, progress, notes, profile], animated: true)
    }
}
