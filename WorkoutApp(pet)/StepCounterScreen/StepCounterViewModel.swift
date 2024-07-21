//
//  StepCounterViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation
import CoreMotion
import FirebaseFirestore
import FirebaseAuth

class StepCounterViewModel {
    private var pedometer = CMPedometer()
    private var db: Firestore
    private var user: User?
    var stepCountData: [StepData] = []
    var onUpdate: (() -> Void)?

    init() {
        db = Firestore.firestore()
        user = Auth.auth().currentUser
        loadData()
    }

    func startStepCounting() {
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)

        pedometer.startUpdates(from: startOfDay) { [weak self] (pedometerData, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    let steps = pedometerData.numberOfSteps.intValue
                    let date = pedometerData.endDate
                    self.updateStepData(date: date, steps: steps)
                }
            }
        }
    }

    private func updateStepData(date: Date, steps: Int) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)

        if let existingIndex = stepCountData.firstIndex(where: { calendar.isDate($0.date, inSameDayAs: startOfDay) }) {
            stepCountData[existingIndex] = StepData(date: startOfDay, steps: steps)
        } else {
            stepCountData.append(StepData(date: startOfDay, steps: steps))
        }

        stepCountData.sort(by: { $0.date < $1.date })

        saveData()
        onUpdate?()
    }

    func initializeChartDataForCurrentWeek() {
        let calendar = Calendar.current
        let now = Date()
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)) else {
            return
        }

        var currentDate = startOfWeek
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!

        while currentDate <= endOfWeek {
            if !stepCountData.contains(where: { calendar.isDate($0.date, inSameDayAs: currentDate) }) {
                stepCountData.append(StepData(date: currentDate, steps: 0))
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        onUpdate?()
    }

    private func saveData() {
        guard let user = user else { return }

        let stepsData = stepCountData.map { (stepData) -> [String: Any] in
            return ["date": stepData.date.timeIntervalSince1970, "steps": stepData.steps]
        }

        db.collection("users").document(user.uid).setData(["stepCountData": stepsData]) { error in
            if let error = error {
                print("Error saving data: \(error)")
            } else {
                print("Data successfully saved")
            }
        }
    }

    private func loadData() {
        guard let user = user else { return }

        db.collection("users").document(user.uid).getDocument { [weak self] (document, error) in
            guard let self = self else { return }

            if let document = document, document.exists {
                if let stepsData = document.data()?["stepCountData"] as? [[String: Any]] {
                    self.stepCountData = stepsData.compactMap { dict in
                        if let date = dict["date"] as? TimeInterval, let steps = dict["steps"] as? Int {
                            return StepData(date: Date(timeIntervalSince1970: date), steps: steps)
                        }
                        return nil
                    }
                }
            } else {
                print("Document does not exist")
            }
            self.initializeChartDataForCurrentWeek()
        }
    }
}
