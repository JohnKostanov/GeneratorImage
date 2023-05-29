//
//  FirstViewController.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 29/5/23.
//

import UIKit

class FirstViewController: UIViewController {
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your request"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "First"
        
        view.addSubview(textField)
        setupConstraints()
    }
    
    func setupConstraints() {
        let constraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

