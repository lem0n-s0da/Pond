//
//  JournalView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct JournalView: View {
    @State private var entries: [JournalEntry] = []
    @State private var showingEditor = false
    @State private var editingEntry: JournalEntry? = nil
    
    @State private var showingDeleteAlert = false
    @State private var entryToDelete: JournalEntry?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(entries.sorted(by: { $0.date > $1.date })) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.date.formatted(date: .long, time: .omitted))
                                .font(.headline)
                                .foregroundStyle(Color(.systemGray2))
                            Text(entry.content)
                                .font(.body)
                                .lineLimit(2)
                                .frame(maxWidth: .infinity)
                            HStack {
                                Button("Edit") {
                                    editingEntry = entry
                                    showingEditor = true
                                }
                                .font(.headline)
                                
                                Spacer()
                                
                                Button(role: .destructive) {
                                    entryToDelete = entry
                                    showingDeleteAlert = true
                                } label: {
                                    Label("Delete", systemImage: "trash").font(.caption)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.mint.opacity(0.1)))
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        editingEntry = nil
                        showingEditor = true
                    }) {
                        VStack {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                            Text("Create Entry")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.mint.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Journal")
            .sheet(isPresented: $showingEditor, onDismiss: fetchEntries) {
                JournalEditorView(entryToEdit: editingEntry)
            }
        }
        .onAppear {
            fetchEntries()
        }
        .alert("Delete Entry?", isPresented: $showingDeleteAlert, presenting: entryToDelete) { entry in
            Button("Delete", role: .destructive) {
                deleteEntry(entry)
            }
            Button("Cancel", role: .cancel) {}
        } message: { entry in
            Text("Are you sure you want to delete this entry?")
        }
    }
    
    func fetchEntries() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("userJournals")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    self.entries = documents.compactMap { doc in
                        let data = doc.data()
                        guard let content = data["content"] as? String,
                              let timestamp = data["date"] as? Timestamp,
                              let userId = data["userId"] as? String else {
                            return nil
                        }
                        return JournalEntry(id: doc.documentID, userId: userId, content: content, date: timestamp.dateValue())
                    }
                }
            }
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        let db = Firestore.firestore()
        db.collection("userJournals").document(entry.id).delete { error in
            if let error = error {
                print("Error deleting entry: \(error)")
            } else {
                entries.removeAll { $0.id == entry.id }
            }
        }
    }
    
}

#Preview {
    //JournalView()
}
