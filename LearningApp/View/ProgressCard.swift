import SwiftUI

struct ProgressCard: View {
    @ObservedObject var viewModel: ActivityVM
    
    var body: some View {
        GlassEffectContainer {
            VStack {
                CalendarHeader(viewModel: viewModel)
                Spacer().frame(height: 20)

                Divider().foregroundColor(.gray).opacity(1)
                Spacer().frame(height: 11)

                Text("Learning \(viewModel.topic)")
                    .font(.system(size: 17).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer().frame(height: 19)

                HStack {
                    Learned(count: viewModel.daysLearned)
                    Spacer().frame(width: 12)
                    Freezed(count: viewModel.daysFreezed)
                }
            }
        }
        .padding(13)
        .glassEffect(.clear, in: .rect(cornerRadius: 20))
    }
}

// MARK: - CalendarHeader
struct CalendarHeader: View {
    @ObservedObject var viewModel: ActivityVM
    @State private var currentDate = Date()
    @State private var showingPicker = false
    @State private var selectedMonth = Calendar.current.component(.month, from: Date()) - 1
    @State private var selectedYear = Calendar.current.component(.year, from: Date())

    private let calendar = Calendar.current

    private var monthYearText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }

    private var weekDays: [String] {
        let formatter = DateFormatter()
        return formatter.shortWeekdaySymbols.map { $0.uppercased() }
    }

    private var weekDates: [Date?] {
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) else {
            return []
        }

        let month = calendar.component(.month, from: currentDate)
        let year = calendar.component(.year, from: currentDate)
        let range = calendar.range(of: .day, in: .month, for: currentDate)!

        let validDays = range.compactMap { day -> Date? in
            let comps = DateComponents(year: year, month: month, day: day)
            return calendar.date(from: comps)
        }

        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
            if validDays.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                return date
            } else {
                return nil
            }
        }
    }

    private func applyMonthYearSelection() {
        var comps = DateComponents()
        comps.year = selectedYear
        comps.month = selectedMonth + 1
        comps.day = 1
        if let newDate = calendar.date(from: comps) {
            currentDate = newDate
            showingPicker = false
        }
    }

    private func goToPreviousWeek() {
        if let newDate = calendar.date(byAdding: .day, value: -7, to: currentDate) {
            currentDate = newDate
            selectedMonth = calendar.component(.month, from: newDate) - 1
            selectedYear = calendar.component(.year, from: newDate)
        }
    }

    private func goToNextWeek() {
        if let newDate = calendar.date(byAdding: .day, value: 7, to: currentDate) {
            currentDate = newDate
            selectedMonth = calendar.component(.month, from: newDate) - 1
            selectedYear = calendar.component(.year, from: newDate)
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text(monthYearText)
                    .bold()
                    .font(.system(size: 17))

                Button {
                    let comps = calendar.dateComponents([.year, .month], from: currentDate)
                    selectedMonth = (comps.month ?? 1) - 1
                    selectedYear = comps.year ?? selectedYear
                    showingPicker.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 17))
                        .bold()
                        .foregroundStyle(Color.orange)
                }
                .popover(isPresented: $showingPicker, arrowEdge: .top) {
                    VStack(spacing: 16) {
                        HStack(spacing: 0) {
                            Picker("Month", selection: $selectedMonth) {
                                ForEach(0..<12, id: \.self) { index in
                                    Text(DateFormatter().monthSymbols[index]).tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)

                            let currentYear = calendar.component(.year, from: Date())
                            Picker("Year", selection: $selectedYear) {
                                ForEach(1900...(currentYear + 50), id: \.self) { year in
                                    Text(String(year)).tag(year)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxWidth: .infinity)
                        }
                        .labelsHidden()
                        .onChange(of: selectedMonth) { _, _ in applyMonthYearSelection() }
                        .onChange(of: selectedYear) { _, _ in applyMonthYearSelection() }
                    }
                    .padding()
                    .presentationCompactAdaptation(.popover)
                    .frame(width: 300, height: 180)
                }

                Spacer()

                Button(action: goToPreviousWeek) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.orange)
                        .bold()
                        .font(.system(size: 17))
                }

                Spacer().frame(width: 20)

                Button(action: goToNextWeek) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(Color.orange)
                        .bold()
                        .font(.system(size: 17))
                }
            }

            Spacer().frame(height: 20)

            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.gray)
                        .frame(maxWidth: .infinity)
                }
            }

            HStack {
                ForEach(weekDates.indices, id: \.self) { index in
                       if let date = weekDates[index] {
                           let day = calendar.component(.day, from: date)
                           let isToday = calendar.isDateInToday(date)
                           let dayStatus = viewModel.getDayStatus(for: date)
                           let isFutureDate = date > Date()
                           
                           Circle()
                               .fill(circleColor(isToday: isToday, status: dayStatus, isFuture: isFutureDate))
                               .frame(width: 35, height: 35)
                               .overlay(
                                   Text("\(day)")
                                       .font(.system(size: 17, weight: .semibold))
                                       .foregroundColor(textColor(isToday: isToday, status: dayStatus, isFuture: isFutureDate))
                               )
                               .frame(maxWidth: .infinity)
                       } else {
                           Circle()
                               .fill(Color.clear)
                               .frame(width: 35, height: 35)
                               .frame(maxWidth: .infinity)
                       }
                   }
            }
        }
    }
    
    private func circleColor(isToday: Bool, status: DayStatus, isFuture: Bool) -> Color {
        if isToday {
            return Color.orange
        }
        
        if isFuture {
            return Color.clear
        }
        
        switch status {
        case .learned:
            return Color.orange.opacity(0.3)
        case .freezed:
            return Color.teal.opacity(0.3)
        case .none:
            return Color.clear
        }
    }

    private func textColor(isToday: Bool, status: DayStatus, isFuture: Bool) -> Color {
        if isToday {
            return Color.white
        }
        
        switch status {
        case .learned:
            return Color.orange
        case .freezed:
            return Color.teal
        case .none:
            return Color.white  // Changed from gray to white
        }
    }
    
}




struct Learned: View {
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundStyle(Color.orange)
                .font(Font.system(size: 20))
            
            VStack(alignment: .leading) {
                Text("\(count)").font(.system(size: 24))
                Text("Days Learned").font(.system(size: 14)).bold()
                Spacer().frame(height: 6)
            }
            Spacer().frame(width: 12)
        }
        .frame(width: 176, height: 73)
        .glassEffect(.clear.tint(Color.orange.opacity(0.25)))
    }
}

struct Freezed: View {
    let count: Int
    
    var body: some View {
        HStack {
            Image(systemName: "cube.fill")
                .foregroundStyle(Color.teal)
                .font(Font.system(size: 20))
            
            VStack(alignment: .leading) {
                Text("\(count)").font(.system(size: 24))
                Text("Days Freezed").font(.system(size: 14)).bold()
                Spacer().frame(height: 6)
            }
            Spacer().frame(width: 12)
        }
        .frame(width: 176, height: 73)
        .glassEffect(.clear.tint(Color.teal.opacity(0.23)))
    }
}

//#Preview {
//  ProgressCard()
//}
