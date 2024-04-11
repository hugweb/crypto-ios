//
//  AppError.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

enum AppError: LocalizedError {
    case failedFetchingAssets
    case failedFetchingTransactions
    case failedSavingTransaction
    case failedDeletingTransaction
    
    var errorDescription: String? {
        switch self {
        case .failedFetchingAssets:
            return "Assets"
        case .failedSavingTransaction, .failedFetchingTransactions, .failedDeletingTransaction:
            return "Transaction"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .failedFetchingAssets:
            return "Sorry, we couldn't retrieve your assets. \n\n Try again later. ☹️"
        case .failedFetchingTransactions:
            return "Sorry, we couldn't retrieve your transactions. \n\n Try again later. ☹️"
        case .failedSavingTransaction:
            return "Sorry, we couldn't save your transaction. \n\n Try again later. ☹️"
        case .failedDeletingTransaction:
            return "Sorry, we couldn't delete your transaction. \n\n Try again later. ☹️"
        }
    }
}

struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    var errorDescription: String? {
        underlyingError.errorDescription
    }
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }
    
    init?(error: AppError?) {
        guard let localizedError = error else { return nil }
        underlyingError = localizedError
    }
}

extension View {
    func errorAlert(error: Binding<AppError?>, buttonTitle: String = "Try again", action: (() -> Void)? = nil) -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
                action?()
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
}
