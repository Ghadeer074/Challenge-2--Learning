//
//  ActivityViewModel.swift
//  LearningApp
//
//  Created by Ghadeer Fallatah on 03/05/1447 AH.
//

import SwiftUI
import Combine

class ActivityVM: ObservableObject {
    
    // MARK: - Persistent properties
    @AppStorage("topic") var topic: String = ""
    @AppStorage("selectedDuration") private var selectedDurationRaw: String = Duration.week.rawValue
    @AppStorage("totalFreezes") var totalFreezes: Int = 2
    @AppStorage("daysLearned") var daysLearned: Int = 0
    @AppStorage("daysFreezed") var daysFreezed: Int = 0
    @AppStorage("freezesUsed") var freezesUsed: Int = 0
    @AppStorage("dayLogsData") private var dayLogsData: Data = Data()
    @AppStorage("lastLoggedTimestamp") private var lastLoggedTimestamp: Double = 0
    
    // MARK: - Published state
    @Published var selectedDuration: Duration = .week
    @Published var currentDayStatus: DayStatus = .none
    @Published var dayLogs: [String: DayStatus] = [:]
    @Published var canLogToday: Bool = true
    @Published var isInitialized = false
    
    private var timer: Timer?
    
    // MARK: - Init
    init() {
        loadStoredData()
        startLogTimer()
    }
    
    // MARK: - Computed
    private var lastLoggedDate: Date? {
        get { lastLoggedTimestamp == 0 ? nil : Date(timeIntervalSince1970: lastLoggedTimestamp) }
        set { lastLoggedTimestamp = newValue?.timeIntervalSince1970 ?? 0 }
    }
    
    // MARK: - Load & Save
    private func loadStoredData() {
        selectedDuration = Duration(rawValue: selectedDurationRaw) ?? .week
        if let decoded = try? JSONDecoder().decode([String: String].self, from: dayLogsData) {
            dayLogs = decoded.compactMapValues { DayStatus(rawValue: $0) }
        }
    }
    
    private func saveDayLogs() {
        if let encoded = try? JSONEncoder().encode(dayLogs.mapValues { $0.rawValue }) {
            dayLogsData = encoded
        }
    }
    
    // MARK: - Goal setup
    func loadGoal(topic: String, duration: Duration) {
        guard !isInitialized else { return }
        self.topic = topic
        self.selectedDuration = duration
        self.selectedDurationRaw = duration.rawValue
        self.totalFreezes = duration.freezeCount
        isInitialized = true
    }
    
    // MARK: - Timer (1 minute reset)
    private func startLogTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.checkIfCanLog()
        }
    }
    
    private func checkIfCanLog() {
        guard let lastLogged = lastLoggedDate else {
            canLogToday = true
            return
        }
        let minutesSinceLastLog = Date().timeIntervalSince(lastLogged) / 60
        // Testing: allow log every 1 minute
        if minutesSinceLastLog >= 1 {
            canLogToday = true
            currentDayStatus = .none
        }
    }
    
    // MARK: - Check status
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
    
    // MARK: - Log actions
    func logAsLearned() {
        guard canLogToday && currentDayStatus == .none else { return }
        
        let today = dateKey(Date())
        dayLogs[today] = .learned
        daysLearned += 1
        currentDayStatus = .learned
        lastLoggedDate = Date()
        canLogToday = false
        saveDayLogs()
    }
    
    func logAsFreezed() {
        guard canLogToday && currentDayStatus == .none && freezesUsed < totalFreezes else { return }
        
        let today = dateKey(Date())
        dayLogs[today] = .freezed
        daysFreezed += 1
        freezesUsed += 1
        currentDayStatus = .freezed
        lastLoggedDate = Date()
        canLogToday = false
        saveDayLogs()
    }
    
    // MARK: - Helpers
    func getDayStatus(for date: Date) -> DayStatus {
        let key = dateKey(date)
        return dayLogs[key] ?? .none
    }
    
    func resetStreak() {
        daysLearned = 0
        daysFreezed = 0
        freezesUsed = 0
        dayLogs = [:]
        lastLoggedDate = nil
        currentDayStatus = .none
        canLogToday = true
        saveDayLogs()
    }
    
    func updateGoal(newTopic: String, newDuration: Duration) {
        topic = newTopic
        selectedDuration = newDuration
        selectedDurationRaw = newDuration.rawValue
        totalFreezes = newDuration.freezeCount
        resetStreak()
    }
    
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
        case .learned: return "Learned\nToday"
        case .freezed: return "Day\nFreezed"
        case .none:    return "Log as\nLearned"
        }
    }
    
    var learnedButtonColor: Color {
        switch currentDayStatus {
        case .learned: return Color.brown.opacity(0.6)
        case .freezed: return Color.teal.opacity(0.3)
        case .none:    return Color.orangeButton
        }
    }
    
    var freezeButtonEnabled: Bool { canLogFreezed }
    
    var freezeCounterText: String {
        return "\(freezesUsed) out of \(totalFreezes) Freezes used"
    }
    
    deinit {
        timer?.invalidate()
    }
}

// MARK: - Codable DayStat
