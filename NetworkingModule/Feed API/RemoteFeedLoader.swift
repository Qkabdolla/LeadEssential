//
//  RemoteFeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

final class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    enum Result: Equatable {
        case success([FeedItem])
        case falture(Error)
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
                completion(FeedItemsMapper.map(data, form: response))
            case .failure:
                completion(.falture(.connectivity))
            }
        }
    }
}
