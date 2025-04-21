//
//  CalendarView.swift
//  Pond
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUI
import FirebaseAuth

struct CalendarView: View {
    @Binding var selectedDate: Date?
    let onDayTapped: (Date) -> Void
    //let moodEntries: [MoodEntry]
    
    private let calendar = Calendar.current
    private let currentDate = Date()
    
    var body: some View {
        let days = generateMonthDays()
        
        VStack {
            Text(monthTitle(currentDate))
                .font(.headline)
                .padding(.bottom, 15)
            
            HStack {
                ForEach(Calendar.current.shortWeekdaySymbols, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { day in
                    Button {
                        onDayTapped(day)
                    } label: {
                        Text(dayNumber(day))
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(6)
                    }
                }
            }
        }
    }
    
    private func generateMonthDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else { return [] }
        
        let start = monthInterval.start
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        
        var days: [Date] = []
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: start) {
                days.append(date)
            }
        }
        return days
    }
    
    private func monthTitle(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
    
    private func dayNumber(_ date: Date) -> String {
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }
    
}

#Preview {
    //CalendarView()
}
