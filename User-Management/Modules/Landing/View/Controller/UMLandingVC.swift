//
//  UMLandingVC.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 20/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import UIKit

class UMLandingVC: UIViewController {
    
    // MARK: - Outlets
    var usersListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightGray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: .zero)
        
        return tableView
    }()

    let noDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "Opps!!. Error occured, Please try again later."
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .medium)
        av.color = .blue
        av.hidesWhenStopped = true
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()
    
    
    
    // MARK: - Properties
    lazy var landingViewModel: UMLandingViewModel = {
        let viewModel = UMLandingViewModel(dataSource: self.datasource)
        return viewModel
    }()

    let datasource = UMUserDataSource()
    
    
    
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupVC()
        self.setupUsersListTableView()
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.usersListTableView.reloadData()
    }
    
    private func setupVC(){
        self.view.backgroundColor = .white
        
        self.landingViewModel = UMLandingViewModel(dataSource: self.datasource)
    }
    
    private func setupUI(){
        
        self.navigationItem.title = "Home"
    }
    
    private func setupUsersListTableView(){
        self.view.addSubview(self.usersListTableView)
        self.view.addSubview(self.activityIndicator)
        
        NSLayoutConstraint.activate([
            //User TableView Constraints
            self.usersListTableView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.usersListTableView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.usersListTableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor),
            self.usersListTableView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
           
            //Activity Indicator Constraints
            self.activityIndicator.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45),
            self.activityIndicator.heightAnchor.constraint(equalTo: self.activityIndicator.widthAnchor, multiplier: 1),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
        self.usersListTableView.dataSource = self.datasource
        self.usersListTableView.delegate = self
        self.usersListTableView.register(UMUserTVC.self, forCellReuseIdentifier: UMUserTVC.identifier)
        
        self.datasource.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.usersListTableView.reloadData()
            }

        }
        self.landingViewModel.errorOccured.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                
                guard let strongSelf = self else{return}
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.noDataLabel.isHidden = (strongSelf.landingViewModel.errorOccured.value)
            }

        }

        
    }
    
    private func fetchData(){
        self.activityIndicator.startAnimating()
        self.landingViewModel.fetchUsersList()
        
    }

    
    // MARK: - Navigation Methods
    private func showUserDetailsVC(indexPath:IndexPath){
        self.landingViewModel.showUserDetailsVC(navigationController: self.navigationController, indexPath: indexPath)

    }

    
}

extension UMLandingVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.showUserDetailsVC(indexPath: indexPath )
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.3
    }
    
    
}

