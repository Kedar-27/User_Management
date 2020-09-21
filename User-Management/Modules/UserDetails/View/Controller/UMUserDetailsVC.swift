//
//  UMUserDetailsVC.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import UIKit

class UMUserDetailsVC: UIViewController {

    // MARK: - Outlets
    let bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var userDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = ""
        return label
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = ""
        return label
    }()
    
    lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = ""
        return label
    }()

    lazy var favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "favButton"
        return button
    }()



    // MARK: - Properties
    var userData: UMUserModel
    
    let starImage = UIImage(systemName: "star.fill")?.withTintColor(goldColor, renderingMode: .alwaysOriginal)
    
    
    let starOutlineImage = UIImage(systemName: "star")?.withTintColor(goldColor, renderingMode: .alwaysOriginal)
    
    
    
    // MARK: - Delegates
    weak var delegate: UMLandingViewModelProtocol?
    
    
    // MARK: - UIViewController
    init(data: UMUserModel,delegate: UMLandingViewModelProtocol) {
        self.userData = data
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupVC()
        self.setupDetailsView()
        self.setupUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.endEditing(true)
    }
    
    private func setupVC(){
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "Details"
        
        self.view.accessibilityIdentifier = "User Details"
        self.starOutlineImage?.accessibilityIdentifier = "starOutlineImage"
        self.starImage?.accessibilityIdentifier = "starImage"
        
        self.favButton.addTarget(self, action: #selector(self.favButtonClicked), for: .touchUpInside)
    }
    
    private func setupUI(){
        
        
    }
    
    private func setupDetailsView(){
        self.view.addSubview(self.bgView)
        self.bgView.addSubview(self.userDetailsStackView)
        self.bgView.addSubview(self.favButton)
        
        
        self.userDetailsStackView.addArrangedSubview(self.nameLabel)
        self.userDetailsStackView.addArrangedSubview(self.userNameLabel)
        self.userDetailsStackView.addArrangedSubview(self.phoneLabel)
        self.userDetailsStackView.addArrangedSubview(self.companyLabel)
        self.userDetailsStackView.addArrangedSubview(self.addressLabel)
        self.userDetailsStackView.addArrangedSubview(self.websiteLabel)
        
        
        NSLayoutConstraint.activate([
            self.bgView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
            self.bgView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            self.bgView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.bgView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            
            self.favButton.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),
            self.favButton.widthAnchor.constraint(equalTo: self.favButton.heightAnchor, multiplier: 1),
            self.favButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.favButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            
            
            
            
            self.userDetailsStackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.userDetailsStackView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.userDetailsStackView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.45),
            self.bgView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            
        
            
        ])
        
        self.view.layoutIfNeeded()
    }
    
    private func setupUserData(){
        self.nameLabel.text = "Name: " + self.userData.name
        self.addressLabel.text = "Address: " +  (self.userData.address?.city ?? "")
        self.companyLabel.text = "Company: " +  (self.userData.company?.name ?? "")
        self.phoneLabel.text = "Phone: " + self.userData.phone
        self.userNameLabel.text = "Username: " + self.userData.username
        self.websiteLabel.text = "Website: " + self.userData.website
    
        let image = (self.userData.isFavourite ?? false) ?  starImage : starOutlineImage
        
        self.favButton.setBackgroundImage(image, for: .normal)
    }
    
    
    
    // MARK: - Selectors
    @objc func favButtonClicked(){
        self.userData.toggleIsFavourite()
        
                
        let image = (self.userData.isFavourite ?? false) ?  starImage : starOutlineImage
        
        self.delegate?.toggleUserFavourite(user: userData)
        self.favButton.accessibilityIdentifier = image?.accessibilityIdentifier
        self.favButton.setBackgroundImage(image, for: .normal)
    }
    
    
    
        
}
