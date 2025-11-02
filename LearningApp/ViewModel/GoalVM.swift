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
    
    var activityVM: ActivityVM?
    
    func loadCurrentGoal(from activityVM: ActivityVM) {
        self.activityVM = activityVM
        currentTopic = activityVM.topic
        newTopic = activityVM.topic
        selectedDuration = activityVM.selectedDuration
        freezes = activityVM.totalFreezes
    }
    
    func topicChanged() {
        showCheckButton = (newTopic != currentTopic) && !newTopic.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func selectDuration(_ duration: Duration) {
        selectedDuration = duration
        freezes = duration.freezeCount
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
        print("Updating goal - new topic:\(newTopic), New duration:\(selectedDuration)")
        // Update ActivityViewModel
        activityVM?.updateGoal(newTopic: newTopic, newDuration: selectedDuration)
        print("After Updating - ActivityVm topic:\(activityVM?.topic ?? "nil")")
    }
   
}
