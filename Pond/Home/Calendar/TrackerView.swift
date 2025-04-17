//
//  TrackerView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI
import FirebaseAuth

struct TrackerView: View {
    @State private var selectedDate: Date?
    @State private var showingMoodSheet = false
    
    var body: some View {
        VStack {
            Text("Mood Tracker")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            CalendarView(selectedDate: $selectedDate, onDayTapped: { date in
                selectedDate = date
                showingMoodSheet = true
            })
            .padding()
            Spacer()
        }
        .sheet(isPresented: $showingMoodSheet) {
            if let date = selectedDate {
                //MoodEntrySheet(selectedDate: date)
            }
        }
    }
    
}

#Preview {
    TrackerView()
}
