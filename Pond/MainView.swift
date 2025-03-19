//
//  MainView.swift
//  Pond
//
//  Created by HPro2 on 3/17/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                //Spacer()
                Text("Pond")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Image("Pond Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                
                VStack(spacing: 20) {
                    NavigationLink("Log In", destination: LoginView())
                        //.buttonStyle(.bordered)
                        .frame(maxWidth: 200)
                        .padding()
                        .background(Color.mint)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .cornerRadius(20)
                }
                .padding(5)
                VStack(spacing: 20) {
                    NavigationLink("Sign Up", destination: SignUpView())
                        //.buttonStyle(.bordered)
                        .frame(maxWidth: 200)
                        .padding()
                        .background(Color.mint)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .cornerRadius(20)
                }
                Spacer()
                Button("Continue as Guest"){
                    // log in logic
                }
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                //.background(Color.gray.opacity(0.2))
                .foregroundColor(.indigo)
                .padding(.bottom, 0)
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
