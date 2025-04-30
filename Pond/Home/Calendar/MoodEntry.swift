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
        case .happy: return "#FCE26D" // yellow
        case .sad: return "#546BFF" // blue
        case .angry: return "#D64242" // red
        case .calm: return "#9FD4BE" // light green
        case .anxious: return "#F2A14B" // orange
        case .excited: return "#A8F759" // bright green
        }
    }
}

struct MoodEntry: Codable, Identifiable {
    var id: String
    var date: Date
    var mood: MoodType
}
