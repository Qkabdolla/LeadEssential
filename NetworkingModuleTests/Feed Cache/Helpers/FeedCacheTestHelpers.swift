//
//  FeedCacheTestHelpers.swift
//  NetworkingModuleTests
//
//  Created by Kabdolla on 15.03.2023.
//

import Foundation
@testable import NetworkingModule

func uniqueItem() -> FeedItem {
    return FeedItem(
        id: UUID(),
        description: "any",
        location: "any",
        imageURL: anyURL()
    )
}

func uniqueItems() -> (models: [FeedItem], local: [LocalFeedImage]) {
    let models = [uniqueItem(), uniqueItem()]
    let local = models.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.imageURL) }
    
    return (models, local)
}

extension Date {
    func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: Int) -> Date {
        return self + TimeInterval(seconds)
    }
}
