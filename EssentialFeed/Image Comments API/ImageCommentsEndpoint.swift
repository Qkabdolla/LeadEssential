//
//  ImageCommentsEndpoint.swift
//  EssentialFeed
//
//  Created by Каспи on 21.08.2023.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)

    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appendingPathComponent("/v1/image/\(id.uuidString)/comments")
        }
    }
}
