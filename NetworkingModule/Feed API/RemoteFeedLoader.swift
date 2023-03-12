//
//  RemoteFeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

final class RemoteFeedLoader: FeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    typealias Result = LoadFeedResult
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data, let response):
                do {
                    let items = try FeedItemsMapper.map(data, form: response)
                    completion(.success(items.toModels()))
                } catch {
                    completion(.failure(error))
                }
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}

private extension Array where Element == RemoteFeedItem {
    func toModels() -> [FeedItem] {
        return map { FeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.image) }
    }
}
