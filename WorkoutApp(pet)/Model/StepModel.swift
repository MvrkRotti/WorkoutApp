//
//  SteepModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import Foundation

class StepModel {
    var dailyGoal: Int = 10_000
    var currentSteps: Int = 0
    var weeklySteps: [StepData] = []
    
    func updateSteps(for date: Date, steps: Int) {
        currentSteps = steps
        if let index = weeklySteps.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: date) }) {
            weeklySteps[index].steps = steps
        } else {
            weeklySteps.append(StepData(steps: steps, date: date))
        }
    }
    
    func resetDailySteps() {
        currentSteps = 0
    }
}
