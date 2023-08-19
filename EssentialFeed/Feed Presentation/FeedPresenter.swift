//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Каспи on 30.04.2023.
//

import Foundation

public final class FeedPresenter {
    public static var title: String {
        NSLocalizedString("FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Title for the feed view")
    }

    public static func map(_ feed: [FeedItem]) -> FeedViewModel {
        FeedViewModel(feed: feed)
    }
}
