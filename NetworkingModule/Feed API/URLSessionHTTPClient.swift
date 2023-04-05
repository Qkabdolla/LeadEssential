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

    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        session.dataTask(with: url) { data, response, error in
            let result = Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedError()
                }
            }
            
            completion(result)
        }.resume()
    }
}
