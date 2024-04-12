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
}

// MARK: Properties
extension TransactionViewModel {
    
    func totalTransationsValue(for currency: Currency) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = currency.code
        currencyFormatter.maximumFractionDigits = 2
        currencyFormatter.minimumFractionDigits = 0
        
        let usdValue = transactions.map { $0.value }.reduce(0, +)
        let value = usdValue * currency.exchangeRate
        guard value > 0, let formatted = currencyFormatter.string(for: value) else {
            return ""
        }
        return formatted
    }
}

// MARK: Datasource
extension TransactionViewModel {
    
    func fetchTransactions() async {
        do {
            let fetchDescriptor = FetchDescriptor<Transaction>(
                sortBy: [SortDescriptor(\.date, order: .reverse)]
            )
            transactions = try await dataSource.fetch(fetchDescriptor: fetchDescriptor)
        } catch {
            self.error = AppError.failedFetchingTransactions
        }
    }
    
    func deleteTransaction(_ indexSet: IndexSet) async {
        for index in indexSet {
            if transactions.indices.contains(index) {
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
