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
    var allImages: [UIImage?]
    let keyForSavedImagesPaths = "SavedImagesPaths"
    
    init(maxAmount: Int) {
        self.maxAmount = maxAmount
        self.allImages = [] //[UIImage(named: "image")]
    }
}
