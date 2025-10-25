import SwiftUI
import Foundation
import Combine

struct learningGoal {
    var topic: String
    var duration: Duration
    var freezes: Int
}

enum Duration: String {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    
    var freezeCount: Int {
        switch self {
        case .week:
            return 2
        case .month:
            return 8
        case .year:
            return 96
        }
    }
}
