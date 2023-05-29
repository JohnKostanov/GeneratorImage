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
        textField.placeholder = "Enter your request for image"
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send request", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "First"
        
        view.addSubview(textField)
        view.addSubview(button)
        setupConstraints()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        let constraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // Обработчик действия кнопки
    @objc func buttonTapped() {
        print("Button tapped!")
        print(textField.text ?? "Текстовое поле пустое")
        
        // Дополнительные действия при нажатии на кнопку
    }
}

