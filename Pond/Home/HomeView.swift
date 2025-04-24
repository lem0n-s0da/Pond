//
//  HomeView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI

struct HomeView: View {
    let buttonTitles = ["b1", "b2", "b3", "b4", "b5", "b6"]
    
    var body: some View {
        // mood tracker/clander
        // journal
        // resources
        // distractions
        // quote at top of screen
        // stries of hope
        // videos (meditations, helpful guides, atc)
        
        VStack {
            NavigationStack {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: -55), count: 2), spacing: 35) {
                    NavigationLink(destination: TrackerView()) {
                        GridButtonView(title: "Mood\nTracker")
                    }
                    NavigationLink(destination: JournalView()) {
                        GridButtonView(title: "Journal")
                    }
                    NavigationLink(destination: ResourceView()) {
                        GridButtonView(title: "Resources")
                    }
//                    NavigationLink(destination: TrackerView()) {
//                        GridButtonView(title: "tbd")
//                    }
//                    NavigationLink(destination: TrackerView()) {
//                        GridButtonView(title: "tbd")
//                    }
//                    NavigationLink(destination: TrackerView()) {
//                        GridButtonView(title: "tbd")
//                    }
                }
                .padding()
            }
        }
    }
}

struct GridButtonView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(width: 120, height: 120)
            .background(Color.mint)
            .cornerRadius(35)
    }
}

#Preview {
    HomeView()
}
