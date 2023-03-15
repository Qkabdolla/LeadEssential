//
//  SharedTestHelpers.swift
//  NetworkingModuleTests
//
//  Created by Kabdolla on 15.03.2023.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}
