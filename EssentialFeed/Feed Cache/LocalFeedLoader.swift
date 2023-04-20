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
    
    init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalFeedLoader {
    typealias SaveResult = Result<Void, Error>
    
    func save(_ items: [FeedItem], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedFeed { [weak self] deletionResult in
            guard let self = self else { return }
            
            switch deletionResult {
            case .success:
                self.cahce(items, with: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func cahce(_ items: [FeedItem], with completion: @escaping (SaveResult) -> Void) {
        store.insert(items.toLocalModel(), timestamp: currentDate()) { [weak self] insertionResult in
            guard self != nil else { return }
            
            completion(insertionResult)
        }
    }
}

extension LocalFeedLoader: FeedLoader {
    typealias LoadResult = FeedLoader.Result
    
    func load(completion: @escaping (LoadResult) -> Void) {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(.some(cache)) where FeedCachePolicy.validate(cache.timestamp, against: self.currentDate()):
                completion(.success(cache.feed.toModels()))
            case .success:
                completion(.success([]))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
    
extension LocalFeedLoader {
    func validateCache() {
        store.retrieve { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure:
                self.store.deleteCachedFeed { _ in }
                
            case let .success(.some(cache)) where !FeedCachePolicy.validate(cache.timestamp, against: self.currentDate()):
                self.store.deleteCachedFeed { _ in }
                
            case .success: break
            }
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