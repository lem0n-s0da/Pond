//
//  LoginView.swift
//  Pond
//
//  Created by HPro2 on 3/18/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
    //@AppStorage("isLoggedIn") var isLoggedIn = false
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var loginMessage = ""
    
    var body: some View {
        
        VStack {
            Text("Email")
                .foregroundStyle(.indigo)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
                .padding(.bottom, 25)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text("Password")
                .foregroundStyle(.indigo)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
                .padding(.bottom, 55)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Button("Log In") {
                login()
            }
            .buttonStyle(.bordered)
            
            Text(loginMessage)
                .foregroundStyle(loginMessage == "Login Successful!" ? .green : .gray)
                .padding()
        }
        .padding()
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                loginMessage = "Error Logging In..."
                return
            }
            
            guard let user = authResult?.user else { return }
            print("Login Successful")
            loginMessage = "Login Successful!"
            AuthViewModel().isLoggedIn = true
        }
    }
    
}

#Preview {
    LoginView()
}
