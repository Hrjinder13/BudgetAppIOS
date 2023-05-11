//
//  RecordDetailView.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 6/5/2023.
//

import SwiftUI

struct RecordDetailsView: View {
    
    @State private var presentAlert = false
    @State private var recordName: String = ""
    @State private var recordAmount: String = ""
    @State private var color: Color = .black
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var viewModel = RecordViewModel()
    var record: Record
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(record.date ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding()
                
                HStack(spacing: 32) {
                    Text(record.recordName ?? "")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    Text("\(record.recordAmount?.toDouble() ?? 0.0, specifier: "%0.2f")")
                        .font(.title)
                        .bold()
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    
                    Button {
                        presentAlert = true
                    } label: {
                        Image(systemName: "square.and.pencil.circle.fill")
                    }.alert("Update your Record", isPresented: $presentAlert, actions: {
                        TextField("Record Name", text: $recordName)
                        TextField("Record Amount", text: $recordAmount)
                        
                        Button("Update", action: {
                            viewModel.update(Record(
                                id: record.id,
                                recordName: recordName,
                                recordAmount: recordAmount,
                                type: record.type,
                                userId: record.userId ?? "",
                                date: record.date
                            
                            ))
                            dismiss()
                        })
                        
                        Button("Cancel", role: .cancel, action: {
                            presentAlert = false
                            recordName = ""
                        })
                    }, message: {
                        Text("Please, enter your new Record")
                    })
                }
                
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        viewModel.remove(record.id ?? "")
                        dismiss()
                    } label: {
                       Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            
        }
        .navigationTitle(record.type?.rawValue ?? "")
    
    }

}

struct RecordDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailsView(record: Record(recordName: "", recordAmount: "", type: .expense, userId: ""))
    }
}
