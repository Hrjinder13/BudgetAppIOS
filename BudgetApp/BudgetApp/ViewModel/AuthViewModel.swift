//
//  AuthViewModel.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 2/5/2023.
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
   @Published var user: User? {
        didSet {
            objectWillChange.send()
        }
    }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
           
        }
    }
    
    func signIn(
        emailAddress: String,
        password: String
    ) {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func signUp(
        emailAddress: String,
        password: String
    ) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func forgotPassword(
        email: String
    ) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            print("Error: \(error?.localizedDescription ?? "error on \(#line)")")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
