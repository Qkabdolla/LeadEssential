//
//  RemoteFeedLoader.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL)
}

final class RemoteFeedLoader {
    private let client: HTTPClient
    private let url: URL
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}
