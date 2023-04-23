//
//  FeedItem.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

public struct FeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let imageURL: URL
}
