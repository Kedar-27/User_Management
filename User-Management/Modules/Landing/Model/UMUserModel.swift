//
//  UMUserModel.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 20/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import Foundation


// MARK: - UMUserModel
class UMUserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    var isFavourite: Bool?
    
    func toggleIsFavourite(){
        self.isFavourite = !(self.isFavourite ?? false)
    }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}
