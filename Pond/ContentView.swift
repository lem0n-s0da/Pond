//
//  ContentView.swift
//  Pond
//
//  Created by HPro2 on 4/21/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.isLoggedIn {
                TabBarView()
            } else {
                MainView()
            }
        }
    }
}
