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
//        window.rootViewController = UINavigationController(rootViewController: AddNoteAssembler().buildModule())
//        window.rootViewController = UINavigationController(rootViewController: TabAssembler.buildModule())
        window.rootViewController = UINavigationController(rootViewController: WelcomeAssembler.buildModule())
//        window.rootViewController = UINavigationController(rootViewController: ResetPasswordAssembler.buildModule())

        self.window = window
        self.window?.makeKeyAndVisible()
        FirebaseApp.configure()
    }
}

