//
//  User_ManagementUITests.swift
//  User-ManagementUITests
//
//  Created by Kedar Sukerkar on 19/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import XCTest
@testable import User_Management


class User_ManagementUITests: XCTestCase {

    var app: XCUIApplication!

    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()

    }

    // MARK: - Tests
    func testHomeVCLaunched() {
        app.launch()

        // Make sure we're displaying Landing Screen
        XCTAssertTrue(app.otherElements["Home"].exists)

        // Swipe three times to go through the pages
        app.swipeUp()
        app.swipeUp()
        app.swipeDown()
    }
    
    
    func testUserDetailsNavigation(){
        app.launch()

        app.swipeUp()
        
        let usersListTable = app.tables
        
        usersListTable.cells.element(matching: .cell, identifier: "userscell3").tap()
        
        XCTAssertTrue(app.otherElements["User Details"].exists)
        
        
    }
    
    
    func testFavouriteToggling(){
        app.launch()

        app.swipeUp()

        let usersListTable = app.tables
        let fourthUser = usersListTable.cells.element(matching: .cell, identifier: "userscell4")
        fourthUser.tap()
        
        var favButton = app.buttons["favButton"]
        favButton.tap()
        
        let starImageButton = app.buttons["starImage"]
        favButton = starImageButton
        
        XCTAssertTrue(starImageButton.exists)
    }
    
    func testFavouriteFeaturePersistence(){
        app.launch()

        app.swipeUp()

        let usersListTable = app.tables
        let fourthUser = usersListTable.cells.element(matching: .cell, identifier: "userscell4")
        fourthUser.tap()
        
        var favButton = app.buttons["favButton"]
        favButton.tap()
        
        let starImageButton = app.buttons["starImage"]
        favButton = starImageButton
        XCTAssertTrue(favButton.exists)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()

        fourthUser.tap()
        XCTAssertTrue(favButton.exists)
        
    }

    
    
}
