//
//  TransactionList.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI
import SwiftData

struct TransactionList: View {
    
    @EnvironmentObject var state: AppState
    @StateObject var model: TransactionViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(model.transactions, id: \.self) { transaction in
                    TransactionListRow(transaction: transaction)
                }
                .onDelete { indexSet in
                    Task {
                        await model.deleteTransaction(indexSet)
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("Transactions"))
            .animation(.spring(), value: model.transactions)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(model.totalTransationsValue(for: state.currency))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black.opacity(0.7))
                }
            }
            .task {
                await model.fetchTransactions()
            }
        }
        .errorAlert(error: $model.error) {
            Task {
                await model.fetchTransactions()
            }
        }
    }
}

#Preview {
    let schema = Schema([
        Asset.self,
        Transaction.self
    ])
    
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    let container = try! ModelContainer(for: schema, configurations: [modelConfiguration])
    
    let transaction = Transaction()
    transaction.value = 4000
    transaction.date = Date.now
    transaction.price = 13401.202
    container.mainContext.insert(transaction)
    
    let model = TransactionViewModel(context: container.mainContext)
    
    return TransactionList(model: model)
        .modelContainer(container)
}
