//
//  UMUserDataSource.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import UIKit


class UMUserDataSource:GenericDataSource<UMUserModel>, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UMUserTVC.identifier, for: indexPath) as! UMUserTVC

        let user = self.data.value[indexPath.row]
        cell.configureCell(name: user.name, phone: user.phone, website: user.website, isFavourite: user.isFavourite ?? false)
        cell.accessibilityIdentifier = "userscell\(indexPath.row)"
        return cell

    }

}

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
