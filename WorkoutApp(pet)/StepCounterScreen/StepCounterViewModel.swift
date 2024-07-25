//
//  StepCounterViewController.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation
import CoreMotion
import FirebaseFirestore
import Firebase

class StepCounterViewModel {
    private let stepcounter = CMPedometer()
    private var db: Firestore!
    private var timer: Timer?
    private let calendar = Calendar.current
    
    var stepcounterModel: StepModel {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var weeklySteps: [Int] = [] {
        didSet {
            self.bindWeeklyStepsToController()
        }
    }
    
    var bindViewModelToController: (() -> ()) = {}
    var bindWeeklyStepsToController: (() -> ()) = {}
    
    init() {
        self.stepcounterModel = StepModel(steps: 0, goal: 10_000)
        self.db = Firestore.firestore()
        startPedometrUpdates()
        startDailyUpdate()
        fetchWeeklySteps()
    }
    
    private func startPedometrUpdates() {
        guard CMPedometer.isStepCountingAvailable() else { return }
        
        stepcounter.startUpdates(from: Date()) { [weak self] data, error in
            guard let self = self, error == nil, let data = data else { return }
            
            DispatchQueue.main.async {
                self.stepcounterModel.steps = data.numberOfSteps.intValue
                self.saveStepsToFirestore(steps: data.numberOfSteps.intValue)
            }
        }
    }
    
    private func saveStepsToFirestore(steps: Int) {
        guard let user = Auth.auth().currentUser else { return }
        let docPath = db.collection("stepsData").document(user.uid)
        
        docPath.setData(["steps": steps, "goal": stepcounterModel.goal], merge: true) { error in
            if let error = error {
                print("Error saving steps: \(error.localizedDescription)")
            } else {
                print("Steps successfully saved!")
            }
        }
    }
    
    private func saveWeeklyStepsToFirestore(weeklySteps: [Int]) {
        guard let user = Auth.auth().currentUser else { return }
        let docPath = db.collection("stepsData").document(user.uid)
        
        docPath.setData(["weeklySteps": weeklySteps], merge: true) { error in
            if let error = error {
                print("Error saving weekly steps: \(error.localizedDescription)")
            } else {
                print("Weekly steps successfully saved!")
            }
        }
    }
    
    func setGoal(_ goal: Int) {
        stepcounterModel.goal = goal
        saveGoalToFirebase(goal: goal)
    }
    
    private func saveGoalToFirebase(goal: Int) {
        guard let user = Auth.auth().currentUser else { return }
        let docPath = db.collection("stepsData").document(user.uid)
        
        docPath.setData(["goal": goal], merge: true) { error in
            if let error = error {
                print("Error saving goal: \(error.localizedDescription)")
            } else {
                print("Goal successfully saved!")
            }
        }
    }
    
    private func startDailyUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: 86400, repeats: true, block: { [weak self]  _ in
            self?.resetDailySteps()
        })
    }
    
    private func resetDailySteps() {
        guard let user = Auth.auth().currentUser else { return }
        let docPath = db.collection("stepsData").document(user.uid)
        
        docPath.setData(["steps": 0]) { error in
            if let error = error {
                print("Error resetting daily steps: \(error)")
            } else {
                print("Daily steps successfully reset!")
            }
        }
        
        if weeklySteps.count >= 7 {
            weeklySteps.removeFirst()
        }
        weeklySteps.append(stepcounterModel.steps)
        saveWeeklyStepsToFirestore(weeklySteps: weeklySteps)
    }
    
    private func fetchWeeklySteps() {
        guard let user = Auth.auth().currentUser else { return }
        let docPath = db.collection("stepsData").document(user.uid)
        
        docPath.getDocument { [weak self] document, error in
            if let document = document, document.exists, let data = document.data() {
                self?.weeklySteps = data["weeklySteps"] as? [Int] ?? []
                self?.bindWeeklyStepsToController()
            } else {
                print("Document does not exist")
            }
        }
    }
}
