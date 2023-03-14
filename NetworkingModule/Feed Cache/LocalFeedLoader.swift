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
    typealias LoadResult = LoadFeedResult
    
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
    
    func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .found(feed, timestamp) where self.validate(timestamp):
                completion(.success(feed.toModels() ))
            case .found:
                self.store.deleteCachedFeed { _ in }
                completion(.success([]))
            case .empty:
                completion(.success([]))
            case let .failure(error):
                self.store.deleteCachedFeed { _ in }
                completion(.failure(error))
            }
        }
    }
    
    private var maxAge: Int {
        return 7
    }
    
    private func validate(_ timestamp: Date) -> Bool {
        guard let maxCacheAge = Calendar(identifier: .gregorian).date(byAdding: .day, value: maxAge, to: timestamp) else {
            return false
        }
        return currentDate() < maxCacheAge
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

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedItem] {
        return map {
            FeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.url)
        }
    }
}
