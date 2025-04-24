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
        authListener = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
            self.isLoggedIn = user != nil
        }
    }
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user, error == nil {
                // save w firestore auth
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "username": username,
                    "email": email,
                    "uid": user.uid
                ]) { dbError in
                    completion(dbError)
                }
            } else {
                completion(error)
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.user = nil
        self.isLoggedIn = false
    }
}
