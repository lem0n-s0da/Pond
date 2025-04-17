//
//  MoodEntrySheet.swift
//  Pond
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUI
import FirebaseAuth

struct MoodEntrySheet: View {
    let selectedDate: Date
    @Environment(\.dismiss) var dismiss
    
    let moods = ["Happy", "Sad"]
    @State private var selectedMood: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("How did you feel?")
                    .font(.headline)
                    .padding()
                
                ForEach(moods, id: \.self) { mood in
                    Button(action: {
                        selectedMood = mood
                    }) {
                        Text(mood)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedMood == mood ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                            .foregroundStyle(.black)
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Mood Entry")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Save") {
                saveMood()
                dismiss()
            }.disabled(selectedMood == nil))
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func saveMood() {
        guard let mood = selectedMood, let userID = Auth.auth().currentUser?.uid else { return }
        
        let entry = MoodEntry(userID: userID, mood: mood, date: selectedDate)
        FirestoreManager.saveMood(entry, for: userID) { error in
            if let error = error {
                print("Error saving mood: \(error.localizedDescription)")
            } else {
                print("Mood saved for \(formattedDate(selectedDate))")
            }
        }
    }
    
}

#Preview {
    //MoodEntrySheet()
}
