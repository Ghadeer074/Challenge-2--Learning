import SwiftUI

struct CalendarView: View {
    // Placeholder data for now — will be replaced by ViewModel later
    let months = ["January 2025", "September 2025"]
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

                            // Calendar Grid
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                                ForEach(weekDays, id: \.self) { day in
                                    Text(day)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                // Temporary static layout — replace later with your model
                                ForEach(1..<31) { day in
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
            .navigationTitle("All activities")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(">") { })   
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
