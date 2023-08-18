//
//  FeedLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Каспи on 10.06.2023.
//

import EssentialFeed

//class FeedLoaderWithFallbackComposite: FeedLoader {
//    private let primary: FeedLoader
//    private let fallback: FeedLoader
//    init(primary: FeedLoader, fallback: FeedLoader) {
//        self.primary = primary
//        self.fallback = fallback
//    }
//
//    func load(completion: @escaping (FeedLoader.Result) -> Void) {
//        primary.load { [weak self] result in
//            switch result {
//            case .success: completion(result)
//            case .failure: self?.fallback.load(completion: completion )
//            }
//        }
//    }
//}
