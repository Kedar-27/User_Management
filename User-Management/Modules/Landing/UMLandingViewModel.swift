//
//  UMLandingViewModel.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import UIKit


protocol UMLandingViewModelProtocol: AnyObject {
    func toggleUserFavourite(user:UMUserModel)
}


class UMLandingViewModel {
    
    // MARK: - Properties
    weak var dataSource : GenericDataSource<UMUserModel>?
    
    var errorOccured: DynamicValue<Bool> = DynamicValue(false)
    
    var usersList: [UMUserModel] = []{
        didSet{
            self.dataSource?.data.value = self.usersList
        }
    }
    
    
    // MARK: - Initializers
    init(dataSource : GenericDataSource<UMUserModel>?) {
        self.dataSource = dataSource
    }
    
    

    
    // MARK: - Network Requests
    func fetchUsersList(completion: ((Result<[UMUserModel], Error>) -> Void)? = nil) {
        KSNetworkManager.shared.sendRequest(baseUrl: AppURLs.base,methodType: .get, apiName: AppURLs.getUsersList, parameters: nil, headers: nil) { (result) in
            switch result{
            case .success(let data):
                KSNetworkManager.shared.getJSONDecodedData(from: data) {  [weak self] (result:Result<[UMUserModel], Error>) in
                    switch result{
                    case .success(let data):
                        self?.usersList  = data
                        completion?(.success(data))
                        self?.errorOccured.value = false
                    case .failure(let error):
                        completion?(.failure(error))
                        self?.errorOccured.value = true
                    }
                }
                
            case .failure(let error):
                completion?(.failure(error))
                self.errorOccured.value = true
            }

        }
    }
    

    // MARK: - Navigation Methods
    func showUserDetailsVC(navigationController: UINavigationController?, indexPath: IndexPath){
        let userDetailVC = UMUserDetailsVC(data: self.usersList[indexPath.row],delegate: self)
        
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

extension UMLandingViewModel: UMLandingViewModelProtocol{
    
    func toggleUserFavourite(user: UMUserModel) {
        guard let modifiedUserIndex = self.usersList.firstIndex(where: {$0.id == user.id}) else{return}
        
        self.usersList[modifiedUserIndex].isFavourite = user.isFavourite
    }
}

