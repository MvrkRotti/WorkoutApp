//
//  SceneDelegate.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = UINavigationController(rootViewController: ProfileAssembler.buildModule())
        window.rootViewController = UINavigationController(rootViewController: TabAssembler.buildModule())
//        window.rootViewController = UINavigationController(rootViewController: WelcomeAssembler.buildModule())
//        window.rootViewController = UINavigationController(rootViewController: ResetPasswordAssembler.buildModule())

        self.window = window
        self.window?.makeKeyAndVisible()
        FirebaseApp.configure()
//        
//        var preferredStatusBarStyle: UIStatusBarStyle {
//            return .darkContent // или .darkContent в зависимости от вашего дизайна
//        }
        
//        if #available(iOS 13.0, *) {
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.size.height ?? 0
//                let statusBarView = UIView()
//                statusBarView.backgroundColor = ColorResources.customDarkGrey
//                statusBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: statusBarHeight)
//                window.rootViewController?.view.addSubview(statusBarView)
//            }
//        } else {
//            if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
//                statusBar.backgroundColor = ColorResources.customDarkGrey
//            }
//        }

    }
}

