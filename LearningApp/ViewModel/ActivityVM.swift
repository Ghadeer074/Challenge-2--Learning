//
//  ActivityViewModel.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 03/05/1447 AH.
//

import SwiftUI
import Combine

class ActivityVM: ObservableObject {
    
    // Published properties
    @Published var topic: String = ""
    @Published var selectedDuration: Duration = .week
    @Published var totalFreezes: Int = 2
    @Published var daysLearned: Int = 0
    @Published var daysFreezed: Int = 0
    @Published var freezesUsed: Int = 0
    @Published var currentDayStatus: DayStatus = .none
    @Published var dayLogs: [String: DayStatus] = [:] // Using string keys for dates
    @Published var lastLoggedDate: Date?
    @Published var canLogToday: Bool = true
    
    private var timer: Timer?
    
    init() {
        startLogTimer()
    }
    
    // MARK: - Load Data from OnBoarding
    func loadGoal(topic: String, duration: Duration) {
        self.topic = topic
        self.selectedDuration = duration
        self.totalFreezes = duration.freezeCount
    }
    
    // MARK: - Start Timer (For testing: 2 minutes instead of 24 hours)
    private func startLogTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkIfCanLog()
        }
    }
    
    // MARK: - Check if user can log
    private func checkIfCanLog() {
        guard let lastLogged = lastLoggedDate else {
            canLogToday = true
            return
        }
        
        let minutesSinceLastLog = Date().timeIntervalSince(lastLogged) / 60
        
        // For testing: allow logging every 2 minutes
        if minutesSinceLastLog >= 2 {
            canLogToday = true
            currentDayStatus = .none
            checkStreakStatus()
        }
    }
    
    // MARK: - Check Current Day Status
    func checkCurrentDayStatus() {
        let today = dateKey(Date())
        
        if let status = dayLogs[today] {
            currentDayStatus = status
            canLogToday = false
        } else {
            currentDayStatus = .none
            checkIfCanLog()
        }
    }
    
    // MARK: - Check Streak Status
    private func checkStreakStatus() {
        guard let lastLogged = lastLoggedDate else { return }
        
        let hoursSinceLastLog = Date().timeIntervalSince(lastLogged) / 3600
        
        if hoursSinceLastLog > 32 {
            resetStreak()
        }
    }
    
    // MARK: - Log as Learned
    func logAsLearned() {
        guard canLogToday && currentDayStatus == .none else { return }
        
        let today = dateKey(Date())
        
        dayLogs[today] = .learned
        daysLearned += 1
        currentDayStatus = .learned
        lastLoggedDate = Date()
        canLogToday = false
        
        objectWillChange.send()
    }
    
    // MARK: - Log as Freezed
    func logAsFreezed() {
        guard canLogToday && currentDayStatus == .none && freezesUsed < totalFreezes else { return }
        
        let today = dateKey(Date())
        
        dayLogs[today] = .freezed
        daysFreezed += 1
        freezesUsed += 1
        currentDayStatus = .freezed
        lastLoggedDate = Date()
        canLogToday = false
        
        objectWillChange.send()
    }
    
    // MARK: - Get Day Status for Calendar
    func getDayStatus(for date: Date) -> DayStatus {
        let key = dateKey(date)
        return dayLogs[key] ?? .none
    }
    
    // MARK: - Reset Streak
    func resetStreak() {
        daysLearned = 0
        daysFreezed = 0
        freezesUsed = 0
        dayLogs = [:]
        lastLoggedDate = nil
        currentDayStatus = .none
        canLogToday = true
        
        objectWillChange.send()
    }
    
    // MARK: - Update Goal (called from LearningGoal)
    func updateGoal(newTopic: String, newDuration: Duration) {
        topic = newTopic
        selectedDuration = newDuration
        totalFreezes = newDuration.freezeCount
        resetStreak()
        
        objectWillChange.send()
    }
    
    // MARK: - Helper
    private func dateKey(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // MARK: - Button States
    var canLogLearned: Bool {
        return canLogToday && currentDayStatus == .none
    }
    
    var canLogFreezed: Bool {
        return canLogToday && currentDayStatus == .none && freezesUsed < totalFreezes
    }
    
    var learnedButtonText: String {
        switch currentDayStatus {
        case .learned:
            return "Learned\nToday"
        case .freezed:
            return "Day\nFreezed"
        case .none:
            return "Log as\nLearned"
        }
    }
    
    var learnedButtonColor: Color {
        switch currentDayStatus {
        case .learned:
            return Color.brown.opacity(0.6)
        case .freezed:
            return Color.teal.opacity(0.3)
        case .none:
            return Color.orangeButton
        }
    }
    
    var freezeButtonEnabled: Bool {
        return canLogFreezed
    }
    
    var freezeCounterText: String {
        return "\(freezesUsed) out of \(totalFreezes) Freezes used"
    }
    
    deinit {
        timer?.invalidate()
    }
}
