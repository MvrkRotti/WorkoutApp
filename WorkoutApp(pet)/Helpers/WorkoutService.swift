//
//  WorkoutService.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 29.09.2024.
//

import FirebaseFirestore
import FirebaseAuth

class WorkoutService {
    let db = Firestore.firestore()
    
    func saveWorkout(_ workout: Workout, completion: @escaping (Error?) -> Void) {
        let workoutData: [String: Any] = [
            "sportType": workout.sportType.rawValue,
            "distance": workout.distance,
            "time": workout.time,
            "calories": workout.calories,
            "date": workout.date,
            "userId": workout.userId
        ]
        
        db.collection("workouts").addDocument(data: workoutData) { error in
            completion(error)
        }
    }
}
