//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Каспи on 09.06.2023.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
