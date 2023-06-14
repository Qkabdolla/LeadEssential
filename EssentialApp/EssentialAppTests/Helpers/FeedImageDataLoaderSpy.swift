//
//  FeedImageDataLoaderSpy.swift
//  EssentialAppTests
//
//  Created by Каспи on 14.06.2023.
//

import Foundation
@testable import EssentialFeed
 
class FeedImageDataLoaderSpy: FeedImageDataLoader {
    
    var loadedURLs: [URL] {
        return messages.map { $0.url }
    }
    
    private(set) var cancelledURLs = [URL]()
    private var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    
    private struct Task: FeedImageDataLoaderTask {
        let callback: () -> Void
        func cancel() { callback() }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
    
    func complete(with data: Data, at index: Int = 0) {
        messages[index].completion(.success(data))
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
}
