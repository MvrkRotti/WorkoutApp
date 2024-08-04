//
//  Exercise.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation
import FirebaseFirestore

struct StepData {
    var steps: Int
    var date: Date
    
    init(steps: Int, date: Date) {
        self.steps = steps
        self.date = date
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data(),
              let steps = data["steps"] as? Int,
              let timestamp = data["date"] as? Timestamp else { return nil }
        self.steps = steps
        self.date = timestamp.dateValue()
    }
    
    var dictionary: [String: Any] {
        return [
            "steps": steps,
            "date": Timestamp(date: date)
        ]
    }
}
