//
//  GoalVM.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 03/05/1447 AH.
//
import SwiftUI
import Combine

class GoalVM: ObservableObject {
    
    @Published var currentTopic: String = ""
    @Published var newTopic: String = ""
    @Published var selectedDuration: Duration = .month
    @Published var freezes: Int = 8
    @Published var showAlert: Bool = false
    @Published var showCheckButton: Bool = false
    
    init() {
        loadCurrentGoal()
    }
    
    func loadCurrentGoal() {
        // Load from UserDefaults
        if let savedTopic = UserDefaults.standard.string(forKey: "savedTopic"),
           let savedDurationString = UserDefaults.standard.string(forKey: "savedDuration"),
           let savedDuration = Duration(rawValue: savedDurationString) {
            currentTopic = savedTopic
            newTopic = savedTopic
            selectedDuration = savedDuration
            freezes = UserDefaults.standard.integer(forKey: "savedFreezes")
        } else {
            
            currentTopic = ""
            newTopic = ""
            selectedDuration = .month
            freezes = 8
        }
    }
    
    func topicChanged() {
        showCheckButton = (newTopic != currentTopic) && !newTopic.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func selectDuration(_ duration: Duration) {
        selectedDuration = duration
    }
    
    func checkButtonTapped() {
        if newTopic != currentTopic && !newTopic.isEmpty {
            showAlert = true
        }
    }
    
    func dismissAlert() {
        newTopic = currentTopic
        showAlert = false
        showCheckButton = false
    }
    
    func updateGoal() {
        currentTopic = newTopic
        showAlert = false
        showCheckButton = false
        saveGoal()
    }
    
     func saveGoal() {
        let goal = learningGoal(
            topic: currentTopic,
            duration: selectedDuration,
            freezes: freezes
        )
        
        // Save to UserDefaults
        UserDefaults.standard.set(currentTopic, forKey: "savedTopic")
        UserDefaults.standard.set(selectedDuration.rawValue, forKey: "savedDuration")
        
        print("Updated goal: \(goal)")
    }
}
