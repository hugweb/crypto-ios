//
//  AppError.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

enum AppError: LocalizedError {
    case failedFetchingAssets
  
    var errorDescription: String? {
        switch self {
        case .failedFetchingAssets:
            return "Assets Error"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .failedFetchingAssets:
            return "Sorry, we couldn't retrieve assets. \n Try again later. ☹️"
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
