//
//  FirstViewController.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 29/5/23.
//

import UIKit

enum ErrorRequest: Error {
    case emptyRequest, errorRequest
}

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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "First"
        
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(imageView)
        setupConstraints()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        loadImageFromURL()
    }
    
    func setupConstraints() {
        let constraints = [
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // Обработчик действия кнопки
    @objc func buttonTapped() {
        print("Button tapped!")
        print(textField.text ?? "Текстовое поле пустое")
        
        do {
            try checkTextField(textField.text)
        } catch {
            showAlert(message: "Text field is empty. \nEnter your request.")
            return
        }
        // Дополнительные действия при нажатии на кнопку
        loadImageFromURL(textField.text)
    }
    
    func loadImageFromURL(_ request: String? = nil) {
        let request = request == nil ? "some+text" : "\(textField.text ?? "some+text")"
        let url = URL(string: "https://dummyimage.com/500x500&text=\(request.replacingOccurrences(of: " ", with: "+"))")
        guard let url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let self = self else {
                return
            }
            
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func checkTextField(_ text: String?) throws {
        if textField.text?.isEmpty ?? true {
            throw ErrorRequest.emptyRequest
        }
    }
}

