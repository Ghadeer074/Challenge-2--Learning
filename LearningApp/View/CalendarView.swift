import SwiftUI

struct CalendarView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CalendarViewModel()
    @ObservedObject var activityVM: ActivityVM
    private let weekDays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    var body: some View {
        NavigationStack {
ScrollViewReader { scrollProxy in
    ScrollView {
        VStack(spacing: 30) {
              ForEach(viewModel.months, id: \.self) { monthDate in
                   VStack(alignment: .leading, spacing: 16) {
                       Text(viewModel.monthTitle(for: monthDate))
                  .font(.title3.bold())
                  .foregroundColor(.white)
                  .padding(.leading, 8)
                  .id(viewModel.monthTitle(for: monthDate)) //  gives each month a scroll target
                                
           LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                                    // Weekday headers
                    ForEach(weekDays, id: \.self) { day in
                         Text(day)
                          .font(.caption)
                          .foregroundColor(.gray)
                            }

                           ForEach(viewModel.daysInMonth(for: monthDate), id: \.self) { date in
                                    if let date = date {
                                    let key = dateKey(date)
                                    let status = activityVM.dayLogs[key] ?? .none
                                    DayCircleView(date: date, status: status)
                                        } else {
                                            Color.clear.frame(height: 36)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                .onAppear {
                    // 👇 Scroll to the current month automatically
                    let now = Date()
                    let currentMonthTitle = viewModel.monthTitle(for: now)
                    withAnimation(.easeInOut(duration: 0.6)) {
                        scrollProxy.scrollTo(currentMonthTitle, anchor: .top)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("All activities")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.primary)
                }

//                ToolbarItem(placement: .topBarLeading) {
//                    Button { dismiss() } label: {
//                        Image(systemName: "chevron.left")
//                            .font(.system(size: 17, weight: .semibold))
//                    }
//                }
            }
        }
    }

    private func dateKey(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

// MARK: - Circle Color Logic
struct DayCircleView: View {
    let date: Date
    let status: DayStatus

    private let calendar = Calendar.current

    var body: some View {
        let isToday = calendar.isDateInToday(date)
        let (fillColor, textColor): (Color, Color) = {
            switch (status, isToday) {
            case (_, true): return (.orange, .white)
            case (.learned, _): return (.orange.opacity(0.3), .orange)
            case (.freezed, _): return (.teal.opacity(0.3), .teal)
            default: return (.clear, .white)
            }
        }()

        ZStack {
            Circle()
                .fill(fillColor)
                .frame(width: 36, height: 36)
            Text("\(calendar.component(.day, from: date))")
                .foregroundColor(textColor)
                .font(.body.bold())
        }
        .frame(height: 40)
    }
}

#Preview {
    CalendarView(activityVM: ActivityVM())
}
