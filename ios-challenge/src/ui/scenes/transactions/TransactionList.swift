//
//  TransactionList.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI
import SwiftData

struct TransactionList: View {
    
    @StateObject var model: TransactionViewModel
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(model.transactions, id: \.self) { transaction in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(transaction.date, style: .date)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black.opacity(0.9))
                        HStack {
                            Text(transaction.humanizeValue)
                                .font(.footnote)
                                .foregroundStyle(Color.black.opacity(0.7))
                            Spacer()
                            if let humanizePrice = transaction.humanizePrice {
                                Text(humanizePrice)
                                    .font(.footnote)
                                    .foregroundStyle(Color.black.opacity(0.7))
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    model.deleteTransaction(indexSet)
                }
            }
            .navigationTitle(LocalizedStringKey("Transactions"))
            .animation(.spring(), value: model.transactions)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(model.totalTransationsValue)
                        .font(.title)
                }
            }
        }
        .task {
            model.fetchTransactions()
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
