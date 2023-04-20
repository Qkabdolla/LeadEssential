//
//  RemoteFeedItem.swift
//  NetworkingModule
//
//  Created by Каспи on 12.03.2023.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
