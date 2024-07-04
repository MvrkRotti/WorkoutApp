//
//  NotesAssembler.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 03.04.2024.
//
import UIKit

protocol Router {
    func navigateToLogin(from navigationController: UINavigationController?)
    func navigateToRegister(from navigationController: UINavigationController?)
    func navigateToTabBar(from navigationController: UINavigationController?)
    func navigateToAddNote(from viewController: UIViewController?)
}

class DefaultRouter: Router {
    private weak var assembler: Assembler?

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    func setRootViewController(_ viewController: UIViewController, in window: UIWindow) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func navigateToLogin(from navigationController: UINavigationController?) {
        guard let assembler = assembler else { return }
        let loginVC = assembler.resolve() as AuthorisationViewController
        navigationController?.pushViewController(loginVC, animated: true)
    }

    func navigateToRegister(from navigationController: UINavigationController?) {
        guard let assembler = assembler else { return }
        let registerVC = assembler.resolve() as RegistrationViewController
        navigationController?.pushViewController(registerVC, animated: true)
    }

    func navigateToTabBar(from navigationController: UINavigationController?) {
        guard let assembler = assembler else { return }
        let tabBarController = TabController(assembler: assembler)
        navigationController?.setViewControllers([tabBarController], animated: true)
    }

    func navigateToAddNote(from viewController: UIViewController?) {
            guard let assembler = assembler else { return }
            let addNoteVC = assembler.resolve() as AddNoteViewController
            viewController?.present(addNoteVC, animated: true, completion: nil)
        }
}

