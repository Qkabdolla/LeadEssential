//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Kabdolla on 23.04.2023.
//

import Foundation

protocol FeedImageDataLoaderTask {
    func cancel()
}

protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>

    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
