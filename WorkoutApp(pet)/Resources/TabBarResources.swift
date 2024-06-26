//
//  TabBarResources.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 11.04.2024.
//

import UIKit

enum TabBarResources {
    
    static func icon(for tab: Tabs) -> UIImage? {
        switch tab {
        case .exercises: return UIImage(named: "ExercisesTabIcon")
        case .notes: return UIImage(named: "notesTabIcon")
        case .profile: return UIImage(named: "porfileTabIcon")
        }
    }
    
    static func title(for tab: Tabs) -> String {
        switch tab {
        case .exercises: return Const.handbook
        case .notes: return Const.notes
        case .profile: return Const.profile
        }
    }
}
