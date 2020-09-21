//
//  UMLanding_Tests.swift
//  User-ManagementTests
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import XCTest
@testable import User_Management

class UMLanding_Tests: XCTestCase {
    
    // MARK: - Properties
    lazy var landingViewModel: UMLandingViewModel! = {
        let viewModel = UMLandingViewModel(dataSource: self.datasource)
        return viewModel
    }()
    
    var datasource: UMUserDataSource! = UMUserDataSource()
    
    
    // MARK: - Overrides
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        self.landingViewModel = nil
        self.datasource = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testUserListFetching(){
        
        let promise = expectation(description: "Fetched User List Not empty")
        
        self.landingViewModel.fetchUsersList { (result) in
            switch result{
            case .success(let data):
                
                if data.isEmpty{
                    XCTFail("Users list fetched is empty")
                }else{
                    promise.fulfill()
                }
                
                
            case .failure(let error):
                XCTFail("Receive Error \(error)")
            }
            
            
            
        }
        
        
        
        wait(for: [promise], timeout: 5)
        
    }
    
    
    
}
