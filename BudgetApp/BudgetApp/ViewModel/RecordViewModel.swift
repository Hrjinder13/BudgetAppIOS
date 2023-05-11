//
//  RecordViewModel.swift
//  BudgetApp
//
//  Created by Harjinder Pal Singh on 2/5/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import SwiftUI

public class RecordViewModel: ObservableObject {
    
    @Published var records = [Record]()
    @Published var totalValue: Double = 0.0
    private let path: String = "records"
    private let store = Firestore.firestore()
   
    var userId = ""
    
    private let firebaseAuthVM = AuthViewModel()
    private var cancellables: Set<AnyCancellable> = []
   
    init() {
        firebaseAuthVM.$user
        .compactMap { user in
          user?.uid
        }
        .assign(to: \.userId, on: self)
        .store(in: &cancellables)
      
        firebaseAuthVM.$user
        .receive(on: DispatchQueue.main)
        .sink { [weak self] value in
            self?.get(for: "")
        }
        .store(in: &cancellables)
    }
    
    
    func get(for id: String) {
      store.collection(path)
        .whereField("userId", isEqualTo: id)
        .addSnapshotListener { querySnapshot, error in
          
          if let error = error {
            print("Error getting cards: \(error.localizedDescription)")
            return
          }
          
          self.records = querySnapshot?.documents.compactMap { document in
          
            try? document.data(as: Record.self)
          } ?? []
            
        }
    }

    func add(_ record: Record) {
      do {
        let newRecord = record
        _ = try store.collection(path).addDocument(from: newRecord)
      } catch {
        fatalError("something went wrong: \(error.localizedDescription).")
      }
    }
    
    func update(_ record: Record) {
      do {
          try store.collection(path).document(record.id ?? "").setData(from: record)
      } catch {
        fatalError("something went wrong \(error.localizedDescription).")
      }
    }
    
    func remove(_ id: String)  {
      store.collection(path).document(id).delete { error in
        if let error = error {
          print("something went wrong \(error.localizedDescription)")
        }
      }
    }
    
}
