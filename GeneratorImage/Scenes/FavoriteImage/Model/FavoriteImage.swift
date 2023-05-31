//
//  FavoriteImage.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 31/5/23.
//

import UIKit

class FavoriteImage {
    var image: UIImage?
    let maxAmount: Int
    var allFavoriteImages: [UIImage?]
    
    init(maxAmount: Int) {
        self.maxAmount = maxAmount
        self.allFavoriteImages = [UIImage(named: "image")]
    }
}
