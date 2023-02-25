//
//  HTTPClient.swift
//  NetworkingModule
//
//  Created by Каспи on 25.02.2023.
//

import Foundation

enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
