//
//  AuthViewModel.swift
//  Pond
//
//  Created by HPro2 on 4/21/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var user: User?
    private var authListener: AuthStateDidChangeListenerHandle?
    
    init() {
        listenToAuthState()
    }
    
    func listenToAuthState() {
        
    }
    
}
