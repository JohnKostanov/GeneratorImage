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

protocol ImageDelegate: AnyObject {
    func addImageToFavorites(_ image: UIImage)
}

class FirstViewController: UIViewController {
    let request = RequestView()
    let networkLayer = NetworkLayer()

    weak var delegate: ImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "First"
        
        view.addSubview(request.textField)
        view.addSubview(request.imageView)
        view.addSubview(request.buttonSendRequest)
        view.addSubview(request.buttonAddToFavorites)
        request.setupConstraints(view)
        
        request.buttonSendRequest.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        request.buttonAddToFavorites.addTarget(self, action: #selector(addToFaforites), for: .touchUpInside)
        networkLayer.loadImageFromURL(text: nil, request.imageView)
    }
    
    // Обработчик действия кнопки
    @objc func sendRequest() {
        do {
            try checkTextField(request.textField.text)
        } catch ErrorRequest.emptyRequest {
            showAlert(message: "Text field is empty. \nEnter your request.")
            return
        } catch ErrorRequest.errorRequest {
            showAlert(message: "Text field contains special characters. \nRemove special characters from queries.")
            return
        } catch {
            showAlert(message: "An unknown error occurred.")
        }
        // Дополнительные действия при нажатии на кнопку
        networkLayer.loadImageFromURL(text: request.textField.text, request.imageView)
    }
    
    @objc func addToFaforites() {
        print("Add to favorites")
        if let image = request.imageView.image {
            delegate?.addImageToFavorites(image)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func checkTextField(_ text: String?) throws {
        guard let text else {
            return
        }
        if text.isEmpty {
            throw ErrorRequest.emptyRequest
        }
        
        if containsSpecialCharacters(text: text) {
            throw ErrorRequest.errorRequest
        }
    }
    
    private func containsSpecialCharacters(text: String) -> Bool {
        let pattern = ".*[^A-Za-z0-9\\s].*"
        return text.range(of: pattern, options: .regularExpression) != nil
    }
}
