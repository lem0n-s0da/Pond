//
//  MoodStatsView.swift
//  Pond
//
//  Created by HPro2 on 4/8/25.
//

import SwiftUI

struct MoodStatsView: View {
    var entries: FetchedResults<MoodEntry>
    let calendar = Calendar.current
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Today's Mood: \(moodFor(date: Date()) ?? "No Entry")")
            Text("This Week's Most Common Mood: \(commonThisWeek() ?? "N/A")")
        }
        .font(.subheadline)
        .padding()
    }
    
    func moodFor(date: Date) -> String? {
        entries.first { calendar.isDate($0.date!, inSameDayAs: date) }?.mood
    }
    
    func commonThisWeek() -> String? {
        let weekInterval = calendar.dateInterval(of: .weekOfYear, for: Date())!
        let weekEntries = entries.filter { entry in
            guard let date = entry.date else { return false }
            return weekInterval.contains(date)
        }
        
        let counts = Dictionary(grouping: weekEntries, by: { $0.mood ?? "" })
            .mapValues { $0.count }
        return counts.max(by: { $0.value < $1.value })?.key
    }
    
}
