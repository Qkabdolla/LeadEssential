//
//  FeedItemsMapper.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

public final class FeedItemsMapper {
    private struct Root: Decodable {
        private let items: [RemoteFeedItem]
        
        private struct RemoteFeedItem: Decodable {
            let id: UUID
            let description: String?
            let location: String?
            let image: URL
        }
        
        var images: [FeedItem] {
            items.map { FeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.image) }
        }
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.images
    }
}
