//
//  VestaUITestsLaunchTests.swift
//  VestaUITests
//
//  Created by Edmundas Matusevicius on 2021-09-30.
//

import XCTest

class VestaUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
}
