//
//  FeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

protocol FeedLoader {
    typealias Result = Swift.Result<[FeedItem], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
