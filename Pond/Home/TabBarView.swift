//
//  HomeView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 2 // home
    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarView()
                .tabItem{
                    Label("Tracker", systemImage: "calendar")
                }
                .tag(0)
            
            JournalView()
                .tabItem {
                    Label("Journal", systemImage: "pencil")
                }
                .tag(1)
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(2)
            
            ResourceView()
                .tabItem {
                    Label("Resources", systemImage: "phone")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(4)
        }
    }
}

#Preview {
    TabBarView()
}
