//
//  FeedCachePolicy.swift
//  NetworkingModule
//
//  Created by Каспи on 17.03.2023.
//

import Foundation
 
final class FeedCachePolicy {
    private init() {}
    
    private static var maxCacheAgeInDays: Int {
        return 7
    }
    
    static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = Calendar(identifier: .gregorian).date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }
}
