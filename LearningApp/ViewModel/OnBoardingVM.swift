//
//  OnBoardingVM.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 03/05/1447 AH.
//

import SwiftUI
import Combine

class OnBoardingVM: ObservableObject {
    
    @Published var topic: String = " "
    @Published var selectedDuration: Duration = .week
    @Published var freezes: Int = 2
    @Published var navigateToActivity: Bool = false
    
    func selectDuration(_ duration: Duration) {
        selectedDuration = duration
        freezes = duration.freezeCount
    }
    
    func startLearning() {
        // topic is not empty
        guard !topic.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        // Navigate to Activity page
        navigateToActivity = true
        
        // Save the learning goal
        saveLearningGoal()
    }
    
     func saveLearningGoal() {
        let goal = learningGoal(
            topic: topic,
            duration: selectedDuration,
            freezes: freezes
        )
        
        // Save to UserDefaults
        UserDefaults.standard.set(topic, forKey: "savedTopic")
        UserDefaults.standard.set(selectedDuration.rawValue, forKey: "savedDuration")
        UserDefaults.standard.set(freezes, forKey: "savedFreezes")
        
        print("Saved goal: \(goal)")
    }
}
