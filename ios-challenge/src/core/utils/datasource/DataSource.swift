//
//  Datasource.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI
import SwiftData

enum DataSourceError: LocalizedError, Equatable {
    case savingError
    case deletingError
    case fetchingError
}

@ModelActor
actor DataSource<T: PersistentModel>: ModelActor {
    
    private var context: ModelContext { modelExecutor.modelContext }
    
    public init(container: ModelContainer) {
        self.modelContainer = container
        let context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }
    
    public func fetch(fetchDescriptor: FetchDescriptor<T>) throws -> [T] {
        let list: [T] = try context.fetch(fetchDescriptor)
        return list
    }
    
    public func save(_ data: T? = nil) throws {
        guard let data = data else {
            try context.save()
            return
        }
        context.insert(data)
        try context.save()
    }
    
    public func remove(_ data: T) throws {
        context.delete(data)
    }
    
    public func removeAll() throws {
        try context.delete(model: T.self)
    }
}


