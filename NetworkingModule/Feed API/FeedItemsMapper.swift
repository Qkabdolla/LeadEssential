//
//  FeedItemsMapper.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
    }

    private struct Item: Decodable {
        let id: UUID
        let description: String?
        let location: String?
        let image: URL

        var item: FeedItem {
            return FeedItem(
                id: id,
                description: description,
                location: location,
                imageURL: image
            )
        }
    }
    
    static func map(_ data: Data, form response: HTTPURLResponse) -> RemoteFeedLoader.Result {
        guard response.statusCode == 200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            return .failure(RemoteFeedLoader.Error.invalidData)
        }
        
        let items = root.items.map { $0.item }
        return .success(items)
    }
}
