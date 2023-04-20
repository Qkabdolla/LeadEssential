//
//  CoreDataFeedStore.swift
//  NetworkingModule
//
//  Created by Каспи on 01.04.2023.
//

import CoreData

final class CoreDataFeedStore: FeedStore {
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(moduleName: "NetworkingModule", url: storeURL, in: bundle)
        context = container.newBackgroundContext()
    }
    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        perform { context in
            let result = Result {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
                return ()
            }
            completion(result)
        }
    }
    
    func insert(_ items: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        perform { context in
            let result = Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedImage.images(from: items, in: context)
                
                try context.save()
                
                return ()
            }
            completion(result)
        }
        
    }
    
    func retrieve(completion: @escaping RetrieveCompletion) {
        perform { context in
            let result = Result {
                try ManagedCache.find(in: context).map {
                    return CachedFeed(
                        feed: $0.localFeed,
                        timestamp: $0.timestamp
                    )
                }
            }
            
            completion(result)
        }
    }
    
    private func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }
}
