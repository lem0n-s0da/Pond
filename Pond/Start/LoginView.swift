//
//  LoginView.swift
//  Pond
//
//  Created by HPro2 on 3/18/25.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: UserInfo.entity(), sortDescriptors: []) var users: FetchedResults<UserInfo>
    
    @State private var username = ""
    @State private var password = ""
    @State private var loginMessage = ""
    
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
        if let user = users.first(where: {$0.username == username && $0.password == password }) {
            loginMessage = "Login Successful!"
        } else {
            loginMessage = "Invalid username or password"
        }
    }
    
}

#Preview {
    LoginView()
}
