//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Каспи on 14.06.2023.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedItem]) throws
}
