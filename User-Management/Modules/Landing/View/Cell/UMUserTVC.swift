//
//  UMUserTVC.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import UIKit

class UMUserTVC: UITableViewCell {
    
    
    // MARK: - Outlets
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    
    
    
    // MARK: - Properties
    static let identifier = String(describing: UMUserTVC.self)
    

    // MARK: - UIView
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }
    
    func setupView(){
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.phoneLabel)
        self.contentView.addSubview(self.websiteLabel)
        self.contentView.addSubview(self.starImageView)
        
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor , constant: 10),
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.starImageView.leadingAnchor),
            
            self.phoneLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor , constant: 0),
            self.phoneLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 10),
            self.phoneLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            
            self.websiteLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor , constant: 0),
            self.websiteLabel.topAnchor.constraint(equalTo: self.phoneLabel.bottomAnchor,constant: 10),
            self.websiteLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            
        
            
            self.starImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
            self.starImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            self.starImageView.widthAnchor.constraint(equalTo: self.starImageView.heightAnchor,multiplier: 0.4),
            self.starImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
        
        ])
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.starImageView.image = nil
    }
    
    
    
    
    func configureCell(name: String, phone: String, website: String, isFavourite: Bool){
        
        self.nameLabel.text = name
        self.phoneLabel.text = phone
        self.websiteLabel.text = website
                
        self.starImageView.image = isFavourite ?  UIImage(systemName: "star.fill")?.withTintColor(goldColor, renderingMode: .alwaysOriginal) : UIImage(systemName: "star")?.withTintColor(goldColor, renderingMode: .alwaysOriginal)
    }
    
    
    
    // MARK: - Selectors

}
