//
//  TransactionListRow.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 11/4/24.
//

import SwiftUI

struct TransactionListRow: View {
    
    @EnvironmentObject var state: AppState
    
    let transaction: Transaction
    
    private var formatter: TransactionFormatter {
        return TransactionFormatter(transaction: transaction)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(transaction.date, style: .date)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black.opacity(0.7))
                Spacer()
                Text(transaction.symbol)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black.opacity(0.7))
            }
            HStack {
                Text(formatter.price(for: state.currency))
                    .foregroundStyle(Color.black.opacity(0.9))
                Spacer()
                Text(formatter.value(for: state.currency))
                    .foregroundStyle(Color.black.opacity(0.7))
            }
        }
    }
}
