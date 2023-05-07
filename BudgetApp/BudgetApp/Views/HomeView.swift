//
//  HomeView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 27/4/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @State private var colour: Color = .black
    @State private var expensesSum = 0.0
    @State private var incomeSum = 0.0
    
    var body: some View {
        NavigationStack {
            List {}
                .onAppear {}
            .navigationTitle("Dashboard")
            .navigationBarItems(trailing: Button(action: {
                
            }) {
                Image(systemName: "plus")
                    .font(.title2)
            })
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            authModel.signOut()
                        },
                        label: {
                            Text("Sign Out")
                                .bold()
                        }
                    )
                    Button(
                        action: {
                            
                        },
                        label: {
                            Image(systemName: "arrow.clockwise.circle.fill")
                        }
                    )
                }
            }
        }
    }
    
    private func getBalance() -> Double {
        return incomeSum - expensesSum
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


