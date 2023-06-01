//
//  RequestView.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 30/5/23.
//

import UIKit

class RequestView {
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your request for image"
        return textField
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let buttonSendRequest: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send request", for: .normal)
        button.backgroundColor  = .lightGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let buttonAddToFavorites: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add image to favorites", for: .normal)
        button.backgroundColor  = .lightGray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupConstraints(_ view: UIView) {
        let constraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            buttonSendRequest.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSendRequest.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            buttonSendRequest.widthAnchor.constraint(equalToConstant: 200),
            buttonSendRequest.heightAnchor.constraint(equalToConstant: 50),
            
            buttonAddToFavorites.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAddToFavorites.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 120),
            buttonAddToFavorites.widthAnchor.constraint(equalToConstant: 200),
            buttonAddToFavorites.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
