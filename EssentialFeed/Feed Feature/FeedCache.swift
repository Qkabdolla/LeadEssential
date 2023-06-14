//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Каспи on 14.06.2023.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ feed: [FeedItem], completion: @escaping (Result) -> Void)
}
