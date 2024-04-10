//
//  TransactionViewModel.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation
import SwiftData

@MainActor
class TransactionViewModel: ObservableObject {
        
    @Published var transactions = [Transaction]()
    @Published var error: AppError? = nil
    
    private let context: ModelContext
    private let dataSource: DataSource<Transaction>
    
    init(context: ModelContext) {
        self.context = context
        self.dataSource = DataSource<Transaction>(container: context.container)
    }
    
    var totalTransationsValue: String {
        let value = transactions.map { $0.value }.reduce(0, +)
        guard value > 0 else {
            return ""
        }
        return "\(value.formatted(.number.precision(.fractionLength(0)))) $"
    }
}

extension TransactionViewModel {
    
    func fetchTransactions() {
        Task {
            do {
                let fetchDescriptor = FetchDescriptor<Transaction>(
                    sortBy: [SortDescriptor(\.date, order: .reverse)]
                )
                transactions = try await dataSource.fetch(fetchDescriptor: fetchDescriptor)
            } catch {
                self.error = AppError.failedFetchingTransactions
            }
        }
    }
    
    func deleteTransaction(_ indexSet: IndexSet) {
        for index in indexSet {
            if transactions.indices.contains(index) {
                Task {
                    do {
                        let transaction = transactions[index]
                        transactions.remove(at: index)
                        try await dataSource.remove(transaction)
                    } catch {
                        self.error = AppError.failedDeletingTransaction
                    }
                }
            }
        }
    }
}
