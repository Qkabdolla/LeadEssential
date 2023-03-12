//
//  LocalFeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 12.03.2023.
//

import Foundation

class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    typealias SaveResult = Error?
    
    init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self = self else { return }
            
            if let cacheDeletionError = error {
                completion(cacheDeletionError)
            } else {
                self.cahce(items, with: completion)
            }
        }
    }
    
    private func cahce(_ items: [FeedItem], with completion: @escaping (SaveResult) -> Void) {
        store.insert(items.toLocalModel(), timestamp: currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == FeedItem {
    func toLocalModel() -> [LocalFeedImage] {
        return map {
            LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.imageURL)
        }
    }
}
