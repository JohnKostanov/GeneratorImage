//
//  NetworkLayer.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 30/5/23.
//

import UIKit

class NetworkLayer {
    func loadImageFromURL(text: String?, _ imageView: UIImageView) {
        let requestText = text == nil ? "some+text" : "\(text!)"
        let url = URL(string: "https://dummyimage.com/500x500&text=\(requestText.replacingOccurrences(of: " ", with: "+"))")
        guard let url else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }.resume()
    }
}
