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
    var assembler: Assembler!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        FirebaseApp.configure()
        
        window = UIWindow(windowScene: windowScene)
        assembler = DefaultAssembler()
        let router = DefaultRouter(assembler: assembler)
        
//        let welcomeViewController = assembler.resolve() as WelcomeViewController
//        router.setRootViewController(welcomeViewController, in: window!)
        let tabBarController = TabController(assembler: assembler)
                window?.rootViewController = tabBarController
                window?.makeKeyAndVisible()
    }
}

