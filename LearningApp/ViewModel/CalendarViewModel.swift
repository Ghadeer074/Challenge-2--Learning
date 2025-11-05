//
// Untitled.swift
// LearningApp
// Created by Ghadeer Fallatah on 26/04/1447 AH.
//
//
// CalendarViewModel.swift

 import SwiftUI
 import Combine

class CalendarViewModel: ObservableObject {
    @Published var months: [Date] = []
    private let calendar = Calendar.current

    init() {
        generateMonths()
    }

     func generateMonths() {
        let startYear = 2025
        let endYear = 2040
        for year in startYear...endYear {
            for month in 1...12 {
                if let date = calendar.date(from: DateComponents(year: year, month: month, day: 1)) {
                    months.append(date)
                }
            }
        }
    }

    func daysInMonth(for date: Date) -> [Date?] {
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstWeekday = calendar.component(.weekday, from: calendar.date(from: calendar.dateComponents([.year, .month], from: date))!) - 1

        var days: [Date?] = Array(repeating: nil, count: firstWeekday)
        for day in range {
            let comps = DateComponents(year: calendar.component(.year, from: date),
                                       month: calendar.component(.month, from: date),
                                       day: day)
            if let newDate = calendar.date(from: comps) {
                days.append(newDate)
            }
        }
        return days
    }

    func monthTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}
