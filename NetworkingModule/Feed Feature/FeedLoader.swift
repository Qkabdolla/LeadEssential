//
//  FeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
