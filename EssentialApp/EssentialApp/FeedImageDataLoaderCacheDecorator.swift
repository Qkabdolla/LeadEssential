//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Каспи on 14.06.2023.
//

import EssentialFeed

class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeed.FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.cache.saveIgnoringResult(data, for: url)
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

private extension FeedImageDataCache {
    func saveIgnoringResult(_ data: Data, for url: URL) {
        save(data, for: url) { _ in }
    }
}
