//
//  SignUpView.swift
//  Pond
//
//  Created by HPro2 on 3/18/25.
//

import SwiftUI
import CoreData

struct SignUpView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var username = ""
    @State private var password = ""
    @State private var successMessage = ""
    
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
        
    }
    
}

#Preview {
    SignUpView()
}
