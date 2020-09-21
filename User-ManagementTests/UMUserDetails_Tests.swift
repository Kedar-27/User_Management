//
//  UMUserDetails_Tests.swift
//  User-ManagementTests
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import XCTest
@testable import User_Management

class UMUserDetails_Tests: XCTestCase {

    // MARK: - Properties
    var mockUser: UMUserModel!
    var userDetailVC: UMUserDetailsVC!
    
    
    // MARK: - Overrides
    override func setUp() {
        self.mockUser = UMUserModel(id: 100, name: "XYZ", username: "XYZ", email: "xyz@example.com", address: nil, phone: "123456", website: "example.com", company: nil, isFavourite: false)
        self.userDetailVC = UMUserDetailsVC(data: self.mockUser, delegate: MockUserDetailObject())
        super.setUp()
    }
    
    override func tearDown() {
        self.mockUser = nil
        self.userDetailVC = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testMarkUserFavourite(){
        self.userDetailVC.favButtonClicked()
        
        XCTAssertNotEqual(self.mockUser.isFavourite, self.userDetailVC.userData.isFavourite)
        
        
    }


}

class MockUserDetailObject: UMLandingViewModelProtocol{
    func toggleUserFavourite(user: UMUserModel) {
    
    }
}
