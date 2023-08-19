//
//  FeedImagePresenterTests.swift
//  NetworkingModuleTests
//
//  Created by Каспи on 30.04.2023.
//

import XCTest
@testable import EssentialFeed

final class FeedImagePresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let image = uniqueItem()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.location, image.location)
    }
}
