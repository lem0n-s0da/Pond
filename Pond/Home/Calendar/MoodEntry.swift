//
//  MoodEntry.swift
//  Pond
//
//  Created by Student on 4/24/25.
//

import Foundation

enum MoodType: String, Codable, CaseIterable {
    case happy, sad, angry, calm, anxious, excited
    
    var colorHex: String {
        switch self {
        case .happy: return "#FFD700" // yellow
        case .sad: return "#0000FF" // blue
        case .angry: return "#FF6347" // red
        case .calm: return "#90EE90" // light green
        case .anxious: return "#9370DB" // purple
        case .excited: return "#FFA500" // orange
        }
    }
}

struct MoodEntry: Codable, Identifiable {
    var id: String
    var date: Date
    var mood: MoodType
}
