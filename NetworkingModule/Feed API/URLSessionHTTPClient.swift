//
//  URLSessionHTTPClient.swift
//  NetworkingModule
//
//  Created by Каспи on 28.02.2023.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }
    
    struct UnexpectedError: Error {}

    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedError()))
            }
        }.resume()
    }
}
