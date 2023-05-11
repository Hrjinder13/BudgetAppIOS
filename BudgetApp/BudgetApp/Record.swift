//
//  Record.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 5/5/2023.
//

import Foundation
import FirebaseFirestoreSwift

enum RecordType: String, Codable, CaseIterable {
    case expense = "Expense"
    case income = "Income"
}

extension RecordType: Identifiable {
    var id: String { rawValue }
}

struct Record: Identifiable, Codable {
  @DocumentID var id: String?
    var recordName: String?
    var recordAmount: String?
    var type: RecordType?
    var userId: String?
    var date: String?
}
