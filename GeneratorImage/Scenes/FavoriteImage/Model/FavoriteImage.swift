//
//  FavoriteImage.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 31/5/23.
//

import UIKit

class FavoriteImage {
    var image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
}

extension FavoriteImage {
    static var getAllFavoriteImages: [UIImage?] {
        [UIImage(named: "image")]
    }
}
