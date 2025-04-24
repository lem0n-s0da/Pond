//
//  SignUpView.swift
//  Pond
//
//  Created by HPro2 on 3/18/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    
    // Password requirments
    private var isValidLength: Bool { password.count >= 8 }
    private var hasUpperAndLower: Bool {
        password.range(of: "[A-Z]", options: .regularExpression) != nil &&
        password.range(of: "[a-z]", options: .regularExpression) != nil
    }
    private var hasNumber: Bool {
        password.range(of: "[0-9]", options: .regularExpression) != nil
    }
    private var isPasswordValid: Bool {
        isValidLength && hasUpperAndLower && hasNumber
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Create Account")
                .font(.largeTitle)
            
            Text("Username")
                .foregroundStyle(.indigo)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
                .padding(.bottom, 25)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text("Email")
                .foregroundStyle(.indigo)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding(.top, 10)
                .padding(.bottom, 25)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text("Password")
                .foregroundStyle(.indigo)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 10)
                .padding(.bottom, 15)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading) {
                Text("- At least 8 characters long")
                    .foregroundStyle(isValidLength ? .green : .gray)
                Text("- Includes at least one uppercase and lowercase letter")
                    .foregroundStyle(hasUpperAndLower ? .green : .gray)
                Text("- Includes at least one number")
                    .foregroundStyle(hasNumber ? .green : .gray)
            }
            .font(.footnote)
            .padding(.horizontal)
            .padding(.bottom, 25)
            
            Button("Sign Up") {
                if isPasswordValid {
                    authViewModel.signUp(username: username, email: email, password: password) { error in
                        if let error = error {
                            message = error.localizedDescription
                        } else {
                            message = "Account Created Successfully"
                        }
                    }
                } else {
                    message = "Password does not meet all requirments"
                }
            }
            //.buttonStyle(.bordered)
            .font(.title3.bold())
            .frame(width: 125, height: 50)
            .background(Color .mint)
            .foregroundStyle(.white)
            .cornerRadius(10)
            
            
            if message != "Account Created Successfully" {
                Text(message)
                    .foregroundStyle(.red)
                    .padding()
            } else {
                Text(message)
                    .foregroundColor(.mint)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
