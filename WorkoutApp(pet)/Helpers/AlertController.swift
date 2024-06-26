//
//  AlertController.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 13.05.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: Const.alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Const.cancelAction, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
