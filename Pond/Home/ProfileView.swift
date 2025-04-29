//
//  ProfileView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
            
            Button("Sign Out") {
                AuthViewModel().signOut()
            }
        }
    }
}

#Preview {
    ProfileView()
}
