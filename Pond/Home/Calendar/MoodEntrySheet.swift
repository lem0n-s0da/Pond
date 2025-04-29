//
//  MoodEntrySheet.swift
//  Pond
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct MoodEntrySheet: View {
    let date: Date
    let existingMood: MoodType?
    let onSave: () -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedMood: MoodType?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("How do you feel?")
                    .padding()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                    ForEach(MoodType.allCases, id: \.self) { mood in
                        Button(action: {
                            selectedMood = mood
                        }) {
                            Text(mood.rawValue.capitalized)
                                .padding()
                                .foregroundStyle(.black)
                                .background(mood.colorHex == selectedMood?.colorHex ? Color(hex: mood.colorHex).opacity(0.8) : Color(hex: mood.colorHex).opacity(0.3))
                                .cornerRadius(10)
                        }
                    }
                }
                
                Button("Save") {
                    saveMood()
                }
                .disabled(selectedMood == nil)
                .padding()
                
                Spacer()
            }
            .navigationTitle("Mood Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                selectedMood = existingMood
            }
        }
    }
    
    private func fornatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func saveMood() {
        guard let mood = selectedMood, let userID = Auth.auth().currentUser?.uid else {
            print("Error rip")
            return
        }
        
        let db = Firestore.firestore()
        let day = Calendar.current.startOfDay(for: date)
        //let docId = ISO8601DateFormatter().string(from: day)
        
        let data: [String: Any] = [
            "uid": userID,
            "date": Timestamp(date: day),
            "mood": mood.rawValue
        ]
//        print("Mood to save: \(data.values)")
        // .collection("moodEntries").document(docId)
        //db.collection("users").document(userID).setData(data, merge: true)
        db.collection("userMoods").document("moodEntries\(day)").setData(data, merge: true) { error in
            if let error = error {
                print("Error saving mood: \(error)")
            } else {
                print("\(data) saved to \(userID)")
                onSave()
                dismiss()
            }
        }
    }
}

#Preview {
    //MoodEntrySheet()
}
