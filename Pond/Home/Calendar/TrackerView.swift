//
//  TrackerView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI
import CoreData

struct TrackerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MoodEntry.date, ascending: true)], animation: .default) private var entries: FetchedResults<MoodEntry>
    
    @State private var selectedDate = Date()
    @State private var showingMoodEntry = false
        
    var body: some View {
        VStack(alignment: .center) {
            Text("Mood Tracker")
                .font(.title)
                .padding(.top, 25)
                .padding(.bottom, 25)
            
            CalendarGridView(selectedDate: $selectedDate, entries: entries) {
                showingMoodEntry = true
            }
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
            
            MoodStatsView(entries: entries)
                .padding(.top, 15)
            Spacer()
        }
        .sheet(isPresented: $showingMoodEntry) {
            MoodEntryView(date: selectedDate)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}

#Preview {
    TrackerView()
}
