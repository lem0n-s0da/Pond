//
//  TrackerView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct TrackerView: View {
    @State private var moodEntries: [MoodEntry] = []
    @State private var selectedDate: Date?
    @State private var showingMoodSheet = false
    @State private var currentEntry: MoodEntry?
    
    var body: some View {
        VStack {
            Text("Mood Tracker")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
                        .padding()
            Spacer()
            
            CalendarView(
                moodEntries: moodEntries,
                onDayTapped: handleDayTap
            )
            .padding(.bottom)
            
            Spacer()
        }
        .sheet(isPresented: $showingMoodSheet) {
            if let selectedDate = selectedDate {
                MoodEntrySheet(
                    selectedDate: selectedDate,
                    currentEntry: currentEntry,
                    onSave: { updated in
                        saveMoodEntry(updated)
                    }
                )
            }
        }
        .onAppear {
            loadMoodEntries()
        }
    }
    
    func handleDayTap(_ date: Date) {
        selectedDate = date
        currentEntry = moodEntries.first {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
        showingMoodSheet = true
    }
    
    func loadMoodEntries() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("moodEntries")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.moodEntries = documents.compactMap {
                    try? $0.data(as: MoodEntry.self)
                }
            }
    }
    
    func saveMoodEntry(_ entry: MoodEntry) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let entryRef = db.collection("users")
            .document(userId)
            .collection("moodEntries")
            .document(entry.id)
        
        do {
            try entryRef.setData(from: entry) { error in
                if error == nil {
                    loadMoodEntries()
                }
            }
        } catch {
            print("Error saving entry: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    TrackerView()
}
