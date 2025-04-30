//
//  JournalEntry.swift
//  Pond
//
//  Created by Student on 4/29/25.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    var id: String
    var userId: String
    var content: String
    var date: Date
}
