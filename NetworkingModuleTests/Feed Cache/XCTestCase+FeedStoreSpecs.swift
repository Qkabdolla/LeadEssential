//
//  XCTestCase+FeedStoreSpecs.swift
//  NetworkingModuleTests
//
//  Created by Каспи on 22.03.2023.
//

import XCTest
@testable import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {
    func deleteCache(from sut: FeedStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?
        sut.deleteCachedFeed { result in
            if case let Result.failure(error) = result { deletionError = error }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) {
        let exp = expectation(description: "Wait for cache insertion")
        
        sut.insert(cache.feed, timestamp: cache.timestamp) { insertionResult in
            switch insertionResult {
            case .success: break
            case let .failure(error):
                XCTAssertNil(error, "Expected feed to be inserted successfully")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func expect(_ sut: FeedStore, toRetrieve expectedResult: FeedStore.RetrievalResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrievalResult in
            switch (expectedResult, retrievalResult) {
            case (.success(.none), .success(.none)), (.failure, .failure):
                break
                
            case let (.success(.some(expected)), .success(.some(retrieval))):
                XCTAssertEqual(expected.feed, retrieval.feed, file: file, line: line)
                XCTAssertEqual(expected.timestamp, retrieval.timestamp, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievalResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: FeedStore.RetrievalResult, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
}
