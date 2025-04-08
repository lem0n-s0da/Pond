//
//  CalendarGridView.swift
//  Pond
//
//  Created by HPro2 on 4/8/25.
//

import SwiftUI

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    var entries: FetchedResults<MoodEntry>
    var onDayTap: () -> Void
    
    let calendar = Calendar.current
    let daysInWeek = 7
    
    var body: some View {
        let currentMonth = calendar.dateInterval(of: .month, for: selectedDate)!
        let days = generateDays(for: currentMonth)
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: daysInWeek), spacing: 5) {
            ForEach(days, id: \.self) { day in
                Button(action: {
                    selectedDate = day
                    onDayTap()
                }) {
                    Text("\(calendar.component(.day, from: day))")
                        .frame(width: 50, height: 50)
                        .background(entryFor(date: day) != nil ? Color.blue.opacity(0.6) : Color.clear)
                        .clipShape(Circle())
                        .foregroundStyle(calendar.isDateInToday(day) ? .red : .primary)
                }
            }
        }
    }
    
    func generateDays(for month: DateInterval) -> [Date] {
        var days: [Date] = []
        var current = month.start
        while current < month.end {
            days.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        return days
    }

    func entryFor(date: Date) -> MoodEntry? {
        entries.first { calendar.isDate($0.date!, inSameDayAs: date) }
    }
    
}

