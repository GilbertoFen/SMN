// CalendarView.swift
import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    var appointments: [AppointmentModel]  // <- AppointmentModel en lugar de Appointment

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let weekDays = ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb"]

    var appointmentDaySet: Set<String> {
        Set(appointments.map { $0.date })
    }

    var daysInMonth: [Date?] {
        guard
            let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)),
            let range = calendar.range(of: .day, in: .month, for: monthStart)
        else { return [] }

        let firstWeekday = calendar.component(.weekday, from: monthStart) - 1
        var days: [Date?] = Array(repeating: nil, count: firstWeekday)
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: monthStart) {
                days.append(date)
            }
        }
        return days
    }

    var monthTitle: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth).capitalized
    }

    func dateKey(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: date)
    }

    func isToday(_ date: Date) -> Bool { calendar.isDateInToday(date) }
    func isSelected(_ date: Date) -> Bool { calendar.isDate(date, inSameDayAs: selectedDate) }
    func hasAppointment(_ date: Date) -> Bool { appointmentDaySet.contains(dateKey(date)) }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.green.opacity(0.5))
                        .padding(8)
                }
                Spacer()
                Text(monthTitle)
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.green.opacity(0.5))
                        .padding(8)
                }
            }
            .padding(.horizontal, 8)

            LazyVGrid(columns: columns, spacing: 4) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(Array(daysInMonth.enumerated()), id: \.offset) { _, date in
                    if let date {
                        DayCell(
                            date: date,
                            isToday: isToday(date),
                            isSelected: isSelected(date),
                            hasAppointment: hasAppointment(date)
                        )
                        .onTapGesture { selectedDate = date }
                    } else {
                        Color.clear.frame(height: 36)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .background(Color(.systemBackground))
    }

    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            withAnimation(.easeInOut(duration: 0.2)) { currentMonth = newMonth }
        }
    }
    
    struct DayCell: View {
        let date: Date
        let isToday: Bool
        let isSelected: Bool
        let hasAppointment: Bool

        private var dayNumber: String {
            "\(Calendar.current.component(.day, from: date))"
        }

        var body: some View {
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.green.opacity(0.5))
                        .frame(width: 34, height: 34)
                } else if isToday {
                    Circle()
                        .stroke(Color.green.opacity(0.6), lineWidth: 1.5)
                        .frame(width: 34, height: 34)
                }

                VStack(spacing: 2) {
                    Text(dayNumber)
                        .font(.system(size: 15, weight: isToday || isSelected ? .bold : .regular))
                        .foregroundColor(isSelected ? .white : isToday ? .green.opacity(0.7) : .primary)
                    if hasAppointment {
                        Circle()
                            .fill(isSelected ? Color.white : Color.green.opacity(0.6))
                            .frame(width: 5, height: 5)
                    }
                }
            }
            .frame(height: 42)
        }
    }
}
