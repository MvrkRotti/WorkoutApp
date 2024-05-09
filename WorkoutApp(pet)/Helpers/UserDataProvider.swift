//
//  UserDataProvider.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 09.05.2024.
//

import Foundation

class UserDataProvider {
    static let shared = UserDataProvider()
    private let userDefaults = UserDefaults.standard
    
    func saveUser(_ User: User, forUserID userID: String) {
        UserDefaults.standard.set(["name": User.firstName], forKey: "User_ \(userID)")
    }
    
    func getUserName(forUserID userID: String) -> User? {
        guard let userDataDict = userDefaults.dictionary(forKey: "User_\(userID)"),
              let name = userDataDict["name"] as? String
        else {
            return nil
        }
        return User(firstName: name)
    }
}
