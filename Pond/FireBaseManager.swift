//
//  FireBaseManager.swift
//  Pond
//
//  Created by HPro2 on 4/14/25.
//

import FirebaseCore
import FirebaseFirestore

struct FirestoreManager {
    static let db = Firestore.firestore()
    
    static func saveMood(_ entry: MoodEntry, for userID: String, completion: @escaping (Error?) -> Void) {
        let moodData: [String : Any] = [
            "mood": entry.mood,
            "date": Timestamp(date: entry.date)
        ]
        
        db.collection("users")
            .document(userID)
            .collection("moodEntries")
            .addDocument(data: moodData, completion: completion)
    }
    
    static func fetchMoods(for userID: String, completion: @escaping ([MoodEntry]) -> Void) {
        db.collection("users")
            .document(userID)
            .collection("moodEntries")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }
                
                let moods = documents.compactMap { doc -> MoodEntry? in
                    let data = doc.data()
                    guard
                        let mood = data["mood"] as? String,
                        let timestamp = data["date"] as? Timestamp
                    else { return nil }
                    return MoodEntry(id: doc.documentID, userID: userID, mood: mood, date: timestamp.dateValue())
                }
                completion(moods)
            }
    }
    
}
