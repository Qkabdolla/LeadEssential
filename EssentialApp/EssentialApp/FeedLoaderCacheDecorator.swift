//
//  FeedLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Каспи on 14.06.2023.
//

import EssentialFeed

final class FeedLoaderCacheDecorator: FeedLoader {
    
    private let decoratee: FeedLoader
    private let cache: FeedCache
     
    init(decoratee: FeedLoader, cache: FeedCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.cache.saveIgnoringResult(feed)
                completion(.success(feed))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

private extension FeedCache {
    func saveIgnoringResult(_ feed: [FeedItem]) {
        save(feed) { _ in }
    }
}
