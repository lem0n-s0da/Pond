//
//  JournalEditorView.swift
//  Pond
//
//  Created by Student on 4/29/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct JournalEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State private var content: String = ""
    @State private var date: Date = Date()
    var entryToEdit: JournalEntry?
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Entry Date", selection: $date, displayedComponents: .date)
                
                Section(header: Text("Your Entry")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle(entryToEdit == nil ? "New Entry" : "Edit Entry")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEntry()
                    }
                    .disabled(content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let entry = entryToEdit {
                    content = entry.content
                    date = entry.date
                }
            }
        }
    }
    
    func saveEntry() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "content": content,
            "date": date,
            "userId": userId
        ]
        
        db.collection("userJournals").document("\(userId)-\(date)").setData(data, merge: true) { error in
            if let error = error {
                print("Error saving entry: \(error)")
            } else {
                print("\(data) saved to \(userId)")
                dismiss()
            }
        }
    }
    
}

#Preview {
    JournalEditorView()
}
