//
//  FireBaseManager.swift
//  Pond
//
//  Created by HPro2 on 4/14/25.
//

import FirebaseCore
import FirebaseFirestore

struct MoodEntry: Identifiable {
    var id: String = UUID().uuidString
    var userID: String
    var mood: String
    var date: Date
}

class FirestoreManager {
    static let db = Firestore.firestore()
    
    static func saveMood(_ entry: MoodEntry, for userID: String, completion: @escaping (Error?) -> Void) {
        let moodData: [String: Any] = [
            "mood": entry.mood,
            "date": Timestamp(date: entry.date)
        ]
        
        db.collection("users")
            .document(userID)
            .collection("moodEntries")
            .addDocument(data: moodData, completion: completion)
        
    }
}
