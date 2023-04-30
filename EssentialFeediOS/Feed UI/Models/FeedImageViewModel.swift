//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Каспи on 30.04.2023.
//

import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
