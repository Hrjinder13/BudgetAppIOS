//
//  HomeView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 27/4/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    @ObservedObject private var recordViewModel = RecordViewModel()
    @State private var colour: Color = .black
    @State private var expensesSum = 0.0
    @State private var incomeSum = 0.0
    @State private var ispresentModal = false
    @State private var totalBalance = 0.0
    
    var body: some View {
        NavigationStack {
            List {
                Section("Balance") {
                    if getBalance() < 0 {
                        Text("\(getBalance(), specifier: "%0.2f")")
                            .font(.title)
                            .foregroundColor(.red)
                    } else {
                        Text("\(getBalance(), specifier: "%0.2f")")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                    
                }
                
                HStack(alignment: .center) {
                    CardView(
                        cardImageName: "arrow.up.right",
                        cardTitle: "Expenses",
                        cardSubtitle: expensesSum,
                        cardImageColor: .red
                    )
                    
                    Divider()
                    
                    CardView(
                        cardImageName: "arrow.down.forward",
                        cardTitle: "Income",
                        cardSubtitle: incomeSum,
                        cardImageColor: .green
                    )
                    
                }
                
                Section("Transactitons") {
                    ForEach(recordViewModel.records, id:\.id) { Record in
                        NavigationLink(destination: RecordDetailsView(record: Record)) {
                            VStack(alignment: .leading) {
                                Text(Record.recordName ?? "").font(.headline)
                                Record.type == .expense ?
                                Text("\(Record.recordAmount?.toDouble() ?? 0.0, specifier: "%0.2f")")
                                    .foregroundColor(.red) :
                                Text("\(Record.recordAmount?.toDouble() ?? 0.0, specifier: "%0.2f")")
                                    .foregroundColor(.green)
                                
                                
                            }.frame(maxHeight: 200)
                        }
                    }
                    
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    self.recordViewModel.get(for: authModel.user?.uid ?? "")
                    self.getTotal()
                }
            }
            
            .navigationTitle("Dashboard")
            .navigationBarItems(trailing: Button(action: {
                self.ispresentModal = true
            }) {
                Image(systemName: "plus")
                    .font(.title2)
            })
            .sheet(isPresented: $ispresentModal, content: {
                AddRecordView()
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
                            self.recordViewModel.get(for: authModel.user?.uid ?? "")
                            
                            
                        },
                        label: {
                            Image(systemName: "arrow.clockwise.circle.fill")
                        }
                    )
                }
            }
        }
    }
    private func dateToString() -> String {
        let currentDate = DateFormatter
            .localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        return currentDate
    }
    
    private func getTotal() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            let expenses = recordViewModel.records
                .filter { $0.type == .expense }
            
            let income = recordViewModel.records
                .filter { $0.type == .income }
            
            let totalExpensesValue = expenses.map { $0.recordAmount?.toDouble() ?? 0.0 }
                .reduce(0.0, +)
            let totalIncomeValue = income.map { $0.recordAmount?.toDouble() ?? 0.0 }
                .reduce(0.0, +)
            
            expensesSum = totalExpensesValue
            incomeSum = totalIncomeValue
        }
    }
    
    private func getBalance() -> Double {
        return incomeSum - expensesSum
    }
}
