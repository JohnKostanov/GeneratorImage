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
    let requestView = RequestView()
    let networkLayer = NetworkLayer()
    var counterRequest = CounterRequest(maxAmount: 20)

    weak var delegate: ImageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestView.textField.delegate = self
        title = "First"
        view.backgroundColor = .white
        
        view.addSubview(requestView.textField)
        view.addSubview(requestView.imageView)
        view.addSubview(requestView.buttonSendRequest)
        view.addSubview(requestView.buttonAddToFavorites)
        requestView.setupConstraints(view)
        
        requestView.buttonSendRequest.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        requestView.buttonAddToFavorites.addTarget(self, action: #selector(addToFaforites), for: .touchUpInside)
        networkLayer.loadImageFromURL(text: nil, requestView.imageView)
    }
    
    // Обработчик действия кнопки
    @objc func sendRequest() {
        do {
            try checkTextField(requestView.textField.text)
        } catch ErrorRequest.emptyRequest {
            showAlert(message: "Text field is empty. \nEnter your request.")
            return
        } catch ErrorRequest.errorRequest {
            showAlert(message: "Text field contains special characters. \nRemove special characters from queries.")
            return
        } catch {
            showAlert(message: "An unknown error occurred.")
        }
        guard checkCountRequest() else {
            return
        }
        // Дополнительные действия при нажатии на кнопку
        networkLayer.loadImageFromURL(text: requestView.textField.text, requestView.imageView)
    }
    
    @objc func addToFaforites() {
        if let image = requestView.imageView.image {
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
    
    private func checkCountRequest() -> Bool {
        counterRequest.currentCount += 1
        if counterRequest.currentCount > counterRequest.maxAmount {
            showAlert(message: "The number of requests is limited to \(counterRequest.maxAmount). Try again tomorrow.")
            return false
        }
        return true
    }
}

extension FirstViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Скрывает клавиатуру
        return true
    }

}
