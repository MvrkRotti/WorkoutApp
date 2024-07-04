//
//  NotesRouter.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit

protocol NotesRouterProtocol {
    func navigateToAddNote()
}

class NotesRouter: NotesRouterProtocol {
    private weak var assembler: Assembler?
    private weak var navigationController: UINavigationController?
    
    init(assembler: Assembler) {
        self.assembler = assembler
    }
    
    func setRootViewController(_ viewController: UIViewController, in window: UIWindow) {
            let navigationController = UINavigationController(rootViewController: viewController)
            self.navigationController = navigationController
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    
    func navigateToAddNote() {
            guard let assembler = assembler else { return }
        let addNoteVC = assembler.buildModule() as AddNoteViewController
            navigationController?.present(addNoteVC, animated: true, completion: nil)
        }
    

}

