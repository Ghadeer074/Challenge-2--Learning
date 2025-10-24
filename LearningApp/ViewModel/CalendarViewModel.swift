////
////  Untitled.swift
////  LearningApp
////
////  Created by Ghadeer Fallatah on 26/04/1447 AH.
////
//
//// CalendarViewModel.swift
//import SwiftUI
//internal import Combine
//
//struct CalendarDay: Identifiable {
//    let id = UUID()
//    let date: Date
//    let isActive: Bool
//    let isHighlighted: Bool
//}
//
//struct CalendarMonth: Identifiable {
//    let id = UUID()
//    let name: String
//    let year: Int
//    let days: [CalendarDay]
//}
//
//final class CalendarViewModel: ObservableObject {
//    var objectWillChange: ObservableObjectPublisher
//    
//    @Published var months: [CalendarMonth] = []
//    
//    init() {
//        // Mock data (you’ll replace with real logic later)
//        months = [
//            CalendarMonth(
//                name: "January",
//                year: 2025,
//                days: generateDays(for: 2025, month: 1)
//            ),
//            CalendarMonth(
//                name: "September",
//                year: 2025,
//                days: generateDays(for: 2025, month: 9)
//            )
//        ]
//    }
//    
//    private func generateDays(for year: Int, month: Int) -> [CalendarDay] {
//        let calendar = Calendar.current
//        let dateComponents = DateComponents(year: year, month: month)
//        guard let startOfMonth = calendar.date(from: dateComponents),
//              let range = calendar.range(of: .day, in: .month, for: startOfMonth)
//        else { return [] }
//        
//        return range.compactMap { day -> CalendarDay in
//            let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
//            // Simple alternating mock style
//            let isHighlighted = [13,14,20,22].contains(day)
//            return CalendarDay(date: date, isActive: true, isHighlighted: isHighlighted)
//        }
//    }
//}
