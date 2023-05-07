//
//  ContentView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 27/4/2023.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject private var authModel: AuthViewModel
   
    var body: some View {
            Group {
                if authModel.user != nil {
                    HomeView()
                } else {
                    SignUpView()
                }
            }.onAppear {
                authModel.listenToAuthState()
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

