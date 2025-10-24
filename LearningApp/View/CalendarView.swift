import SwiftUI

struct CalendarView: View {
    // Dismiss action for the custom back button
    @Environment(\.dismiss) private var dismiss

    // UI-only placeholder data
    let months = [
        "January 2025",
        "February 2025",
        "March 2025",
        "April 2025",
        "May 2025",
        "June 2025",
        "July 2025",
        "August 2025",
        "September 2025",
        "October 2025",
        "November 2025",
        "December 2025"
    ]
    let weekDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(months, id: \.self) { month in
                        VStack(alignment: .leading, spacing: 16) {
                            // Month Title
                            Text(month)
                                .font(.title3.bold())
                                .foregroundColor(.white)
                                .padding(.leading, 8)

                            // Calendar Grid (UI-only mock)
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                                // Weekday headers
                                ForEach(weekDays, id: \.self) { day in
                                    Text(day)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                // Leading blanks (static UI-only to simulate alignment)
                                ForEach(0..<2, id: \.self) { _ in
                                    Color.clear
                                        .frame(height: 36)
                                }

                                // Fixed day range for UI demo (1...30)
                                ForEach(1...30, id: \.self) { day in
                                    DayCircleView(
                                        number: day,
                                        isHighlighted: [13, 14, 20, 22].contains(day)
                                    )
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Bigger inline title via principal toolbar item
                ToolbarItem(placement: .principal) {
                    Text("All activities")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.primary)
                }

                // Back button on the leading side
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
            }
        }
    }
}

struct DayCircleView: View {
    let number: Int
    let isHighlighted: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(isHighlighted ? Color.blue : Color(red: 0.45, green: 0.3, blue: 0.1))
                .frame(width: 36, height: 36)

            Text("\(number)")
                .foregroundColor(.white)
                .font(.body.bold())
        }
        .frame(height: 40)
    }
}

#Preview {
    CalendarView()
}
