//
//  CoreData+Helpers.swift
//  NetworkingModule
//
//  Created by Каспи on 01.04.2023.
//

import CoreData
 
extension NSPersistentContainer {
    
    enum LoadingError: Swift.Error {
        case moduleNotFound
        case failedToLoadPersistentStores(Swift.Error)
    }
    
    static func load(moduleName name: String, url: URL, in bundle: Bundle) throws -> NSPersistentContainer {
        guard let model = NSManagedObjectModel.with(name: name, in: bundle) else {
            throw LoadingError.moduleNotFound
        }
        
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        var loadError: Swift.Error?
        container.loadPersistentStores { loadError = $1 }
        try loadError.map { throw LoadingError.failedToLoadPersistentStores($0) }
        
        return container
    }
    
}

private extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle
                    .url(forResource: name, withExtension: "momd")
                    .flatMap { NSManagedObjectModel(contentsOf: $0) }
    }
}
