//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 27/4/2023.
//

import SwiftUI
import FirebaseCore

@main
struct BudgetAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
            WindowGroup {
                NavigationView {
                    ContentView().environmentObject(AuthViewModel())
                }
            }
        }
}
