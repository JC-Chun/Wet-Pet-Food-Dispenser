//
//  UserInfo.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/19/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//
//  Temporary user information in settings

import UIKit

class UserInfo: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "catUserImage")
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Wood Leer Engineers"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "primalFeeder1@gatech.edu"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let profileImageDimension: CGFloat = 60
            
            addSubview(profileImageView)
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
            profileImageView.layer.cornerRadius = profileImageDimension / 2
            
            addSubview(usernameLabel)
            usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
            usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
            
            addSubview(emailLabel)
            emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
            emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
