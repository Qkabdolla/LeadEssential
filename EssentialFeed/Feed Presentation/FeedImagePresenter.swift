//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by Каспи on 30.04.2023.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ image: FeedItem) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location)
    }
}
