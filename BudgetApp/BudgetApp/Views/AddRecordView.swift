//
//  AddRecordView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 6/5/2023.
//

import SwiftUI


struct AddRecordView: View {
    
    @State var name: String = ""
    @State var amount: String = ""
    @State var recordType: RecordType = .expense
    @State var date: Date = Date()
    @Environment(\.presentationMode)
    var presentationMode
    @EnvironmentObject private var authModel: AuthViewModel
    
    @ObservedObject private var recordViewModel = RecordViewModel()
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .disableAutocorrection(true)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
              
                    
                    
                Picker(selection: $recordType, label: Text("Record Type")) {
                    ForEach(RecordType.allCases) { type in
                        Text(type.rawValue.capitalized).tag(type)
                    }
                }
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
            }

            .navigationBarItems(
                leading: Button(action: self.onCancelTapped) { Text("Cancel")},
                trailing: Button(action: self.onSaveTapped) { Text("Save")}
            ).navigationBarTitle("New Record")
            
        }
    }
    
    private func onCancelTapped() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func onSaveTapped() {
        recordViewModel
            .add(
                Record(
                    recordName: name,
                    recordAmount: "\(amount)",
                    type: recordType,
                    userId: authModel.user?.uid ?? "",
                    date: dateToString()
                )
            )
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func dateToString() -> String {
        let currentDate = DateFormatter
            .localizedString(from: self.date, dateStyle: .medium, timeStyle: .none)
        return currentDate
    }
}

