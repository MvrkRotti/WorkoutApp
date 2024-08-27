//
//  SceneDelegate.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 03.02.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var assembler: Assembler!
    var router: DefaultRouter!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        FirebaseApp.configure()
        
        window = UIWindow(windowScene: windowScene)
        assembler = DefaultAssembler()
        let router = DefaultRouter(assembler: assembler)
        let initialViewController: UIViewController
        
        let welcomeViewController = assembler.resolve() as WelcomeViewController
        router.setRootViewController(welcomeViewController, in: window!)

        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            initialViewController = TabController(assembler: assembler)
        } else {
            initialViewController = assembler.resolve() as WelcomeViewController
        }
        
        if var initialViewControllerWithRouter = initialViewController as? RouterAccessible {
            initialViewControllerWithRouter.router = router
        }
        
        router.setRootViewController(initialViewController, in: window!)
    }
    }

protocol RouterAccessible {
    var router: DefaultRouter? { get set }
}
