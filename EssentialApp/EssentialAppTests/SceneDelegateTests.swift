//
//  SceneDelegateTests.swift
//  EssentialAppTests
//
//  Created by Каспи on 15.06.2023.
//

import XCTest
@testable import EssentialFeediOS
@testable import EssentialApp

final class SceneDelegateTests: XCTestCase {
    
    func test_sceneWillConnectToSession_configuresRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        
        sut.configureWindow()
        
        let root = sut.window?.rootViewController
        let rootNavigation = root as? UINavigationController
        let topViewController = rootNavigation?.topViewController
        
        XCTAssertNotNil(rootNavigation, "Expected a navigation controller as root, got \(String(describing: root)) instead")
        XCTAssertTrue(topViewController is ListViewController, "Expected a feed controller as top view controller, got \(String(describing: topViewController)) instead")
    }
}
