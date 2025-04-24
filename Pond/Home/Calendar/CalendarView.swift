//
//  CalendarView.swift
//  Pond
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUI

struct CalendarView: View {
    //@Binding var selectedDate: Date?
    let onDayTapped: (Date) -> Void
    let moodEntries: [MoodEntry]
    
    private let calendar = Calendar.current
    private let columns = Array(repeating:  GridItem(.flexible()), count: 7)
    //private let currentDate = Date()
    
    private var currentMonthDates: [Date] {
        let now = Date()
        let range = calendar.range(of: .day, in: .month, for: now)!
        let components = calendar.dateComponents([.year, .month], from: now)
        let startOfMonth = calendar.date(from: components)!
        
        return range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
    
    var body: some View {
        VStack {
            Text(monthTitle)
                .font(.headline)
                .padding(.bottom, 15)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(["Su", "M", "Tu", "W", "Th", "F", "Sa"], id: \.self) { day in
                    Text(day).fontWeight(.semibold)
                }
                
                ForEach(currentMonthDates, id: \.self) { date in
                    let entry = moodEntries.first {
                        Calendar.current.isDate($0.date, inSameDayAs: date)
                    }
                    
                    Circle()
                        .frame(width: 38, height: 38)
                        .foregroundStyle(entry?.mood.color ?? Color.gray.opacity(0.2))
                        .overlay(
                            Text("\(Calendar.current.component(.day, from: date))")
                                .foregroundStyle(.primary)
                        )
                        .onTapGesture {
                            onDayTapped(date)
                        }
                }
            }
        }
        .padding(.horizontal)
    }
    
    var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: Date())
    }
    
//    private func generateMonthDays() -> [Date] {
//        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else { return [] }
//        
//        let start = monthInterval.start
//        let range = calendar.range(of: .day, in: .month, for: currentDate)!
//        
//        var days: [Date] = []
//        for day in range {
//            if let date = calendar.date(byAdding: .day, value: day - 1, to: start) {
//                days.append(date)
//            }
//        }
//        return days
//    }
//    
//    private func monthTitle(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "LLLL yyyy"
//        return formatter.string(from: date)
//    }
//    
//    private func dayNumber(_ date: Date) -> String {
//        let day = calendar.component(.day, from: date)
//        return "\(day)"
//    }
//    
//    private func entryColor(for date: Date) -> Color {
//        if let entry = moodEntries.first(where: {
//            Calendar.current.isDate($0.date, inSameDayAs: date)
//        }) {
//            return moodColor(for: entry.mood)
//        }
//        return Color.clear
//    }
//    
//    private func moodColor(for mood: String) -> Color {
//        switch mood {
//        case "Happy": return .yellow
//        case "Sad": return .blue
//        default: return .gray
//        }
//    }
    
}

#Preview {
    //CalendarView()
}
