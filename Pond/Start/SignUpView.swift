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
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var successMessage = ""
    
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
        
        VStack {
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
                signUp()
            }
            //.buttonStyle(.bordered)
            .font(.title3.bold())
            .frame(width: 125, height: 50)
            .background(Color .mint)
            .foregroundStyle(.white)
            .cornerRadius(10)
            
            Text(successMessage)
                .foregroundColor(.mint)
                .padding()
        }
        .padding()
    }

    private func signUp() {
        
        guard isPasswordValid else {
                    successMessage = "Password does not meet all requirments"
                    return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                successMessage = "Error signing up..."
                return
            }
            
            guard let user = authResult?.user else { return }
            
            let userDoc = [
                "email": email,
                "username": username
            ]
            
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(userDoc) { error in
                    if let error = error {
                        print("Error saving user document: \(error.localizedDescription)")
                        successMessage = "Error signing up..."
                    } else {
                        print("User signed up and saved!")
                        successMessage = "Signed Up Successfully!"
                        UserDefaults.standard.set(user.uid, forKey: "currentUserID")
                        isLoggedIn = true
                    }
                    
                }

        }
        
//        guard isPasswordValid else {
//            successMessage = "Password does not meet all requirments"
//            return
//        }
//        
////        let newUser = UserInfo(context: viewContext)
////        newUser.id = UUID()
////        newUser.username = username
////        newUser.password = password
//        
//        do {
//            //try viewContext.save()
//            successMessage = "Account Created!"
//            //UserDefaults.standard.set(newUser.id?.uuidString, forKey: "currentUserID")
//            isLoggedIn = true
//            dismiss()
//        } catch {
//            print("Error saving user: \(error)")
//        }
    }
    
}

#Preview {
    SignUpView()
}
