//
//  MoodEntryView.swift
//  Pond
//
//  Created by HPro2 on 4/8/25.
//

import SwiftUI

struct MoodEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var date: Date
    @State private var selectedMood: String = ""
    
    let moods = ["Happy", "Sad", "Anxious", "Excited", "Angry", "Tired"]
    //jealous, calm, extatic, depressed, annoyed
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Current Mood")) {
                    Picker("Mood", selection: $selectedMood) {
                        ForEach(moods, id: \.self) { mood in
                            Text(mood)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .navigationTitle("Log Mood")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveMood()
                        dismiss()
                    }
                    .disabled(selectedMood.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveMood() {
        let newEntry = MoodEntry(context: viewContext)
        newEntry.id = UUID()
        newEntry.date = date
        newEntry.mood = selectedMood
        // save user id
        try? viewContext.save()
    }
    
}
