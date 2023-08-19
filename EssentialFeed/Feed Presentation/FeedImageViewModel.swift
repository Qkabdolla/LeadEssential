//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Каспи on 30.04.2023.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
