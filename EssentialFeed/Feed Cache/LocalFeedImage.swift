//
//  LocalFeedItem.swift
//  NetworkingModule
//
//  Created by Каспи on 12.03.2023.
//

import Foundation

struct LocalFeedImage: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let url: URL
}
