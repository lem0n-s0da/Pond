//
//  ProfileView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var isEditingUsername = false
    @State private var newUsername = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    Text(username.isEmpty ? "Username" : username)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(email)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .padding()
                
                Form {
                    Section {
                        if isEditingUsername {
                            TextField("New Username", text: $newUsername)
                            Button("Save") {
                                updateUsername()
                            }
                        } else {
                            Button("Change Username") {
                                isEditingUsername = true
                                newUsername = username
                            }
                        }
                    }
                    
                    Section {
                        Button(role: .destructive) {
                            AuthViewModel().signOut()
                        } label: {
                            Text("Sign Out")
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                loadUserInfo()
            }
        }
    }
    
    func loadUserInfo() {
        guard let user = Auth.auth().currentUser else { return }
        email = user.email ?? ""
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { document, error in
            if let document = document, document.exists {
                username = document.get("username") as? String ?? "Username"
            } else {
                print("No username found.")
            }
        }
    }
    
    func updateUsername() {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).updateData([
            "username": newUsername
        ]) { error in
            if let error = error {
                print("Error updating username: \(error.localizedDescription)")
            } else {
                username = newUsername
                isEditingUsername = false
            }
        }
    }
}

#Preview {
    ProfileView()
}
