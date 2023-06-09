//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Каспи on 09.06.2023.
//

import Foundation

protocol FeedImageDataStore {
    typealias RetrievalResult = Swift.Result<Data?, Error>
    typealias InsertionResult = Swift.Result<Void, Error>

    func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void)
    func retrieve(dataForURL url: URL, completion: @escaping (RetrievalResult) -> Void)
}
