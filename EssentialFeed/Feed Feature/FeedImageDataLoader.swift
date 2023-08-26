//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Kabdolla on 23.04.2023.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
