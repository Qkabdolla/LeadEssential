//
//  FeedItem.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
