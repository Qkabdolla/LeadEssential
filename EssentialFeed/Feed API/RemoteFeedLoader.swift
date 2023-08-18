//
//  RemoteFeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

public typealias RemoteFeedLoader = RemoteLoader<[FeedItem]>

public extension RemoteFeedLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: FeedItemsMapper.map)
    }
}
