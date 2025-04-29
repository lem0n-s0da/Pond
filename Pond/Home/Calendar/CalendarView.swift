//
//  CalendarView.swift
//  Pond
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct CalendarView: View {
    @State private var selectedDate: Date? = nil
    @State private var showingMoodSheet = false
    @State private var moodEntries: [Date: MoodType] = [:]
    
    var body: some View {
        VStack {
            Text("Mood Tracker")
                .font(.largeTitle)
                .padding(.top)
            
            calendarGrid
            
//            if !moodEntries.isEmpty {
//                statisticsSection
//            }
            statisticsSection
            Spacer()
        }
        .onAppear {
            fetchMoodEntries()
        }
        .sheet(isPresented: $showingMoodSheet) {
            if let selected = selectedDate {
                MoodEntrySheet(date: selected, existingMood: moodEntries[selected]) {
                    fetchMoodEntries()
                }
            }
        }
    }
    
    private var calendarGrid: some View {
        let today = Calendar.current.startOfDay(for: Date())
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: today))!
        let range = Calendar.current.range(of: .day, in: .month, for: startOfMonth)!
        let days = range.compactMap { day -> Date? in
            Calendar.current.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
        
        return LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7 ), spacing: 10) {
            ForEach(days, id: \.self) { date in
                Button(action: {
                    selectedDate = date
                    showingMoodSheet = true
                }) {
                    Text("\(Calendar.current.component(.day, from: date))")
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(highlightColor(for: date))
                        )
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
    }
    
    private func highlightColor(for date: Date) -> Color {
        let day = Calendar.current.startOfDay(for: date)
        
        if day == Calendar.current.startOfDay(for: Date()) {
            return Color.blue.opacity(0.4)
        }
        if let mood = moodEntries[day] {
            return Color(hex: mood.colorHex)
        }
        return Color.gray.opacity(0.2)
    }
    
    private func fetchMoodEntries() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        
        db.collection("userMoods").getDocuments() { snapshot, error in
            guard let docs = snapshot?.documents else {
                print("error fetching mood")
                return
            }
            var loadedEntries: [Date: MoodType] = [:]
            
            for doc in docs {
                if let moodString = doc["mood"] as? String,
                   let timestamp = doc["date"] as? Timestamp,
                   let mood = MoodType(rawValue: moodString) {
                    let date = Calendar.current.startOfDay(for: timestamp.dateValue())
                    loadedEntries[date] = mood
                }
            }
            self.moodEntries = loadedEntries
        }
    }
    
    private var statisticsSection: some View {
        VStack(alignment: .leading) {
            Text("Mood Trends This Month")
                .font(.headline)
                .padding(.bottom, 15)
            
            let moodCounts = Dictionary(grouping: moodEntries.values, by: { $0 })
                .mapValues { $0.count }
            let mostCommon = moodCounts.max { $0.value < $1.value }
            
            if let mood = mostCommon?.key {
                Text("Most common mood: \(mood.rawValue.capitalized)")
            }
            if let todayMood = moodEntries[Calendar.current.startOfDay(for: Date())] {
                Text("Today's mood: \(todayMood.rawValue.capitalized)")
            } else {
                Text("No mood logged for today.")
            }
        }
        .padding()
    }
    
}

#Preview {
    //CalendarView()
}
