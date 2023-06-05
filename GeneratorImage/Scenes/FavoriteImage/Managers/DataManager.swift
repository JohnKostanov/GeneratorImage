//
//  DataManager.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 5/6/23.
//

import UIKit

protocol DataManagerDelegate: AnyObject {
    func saveImages(_ data: FavoriteImage)
    func loadSavedImages(_ data: FavoriteImage)
    func removeAllImages(_ data: FavoriteImage)
    
}

class DataManager: DataManagerDelegate {
    
    let defaults = UserDefaults.standard
    
    func saveImages(_ data: FavoriteImage) {
        // Получаем путь к директории для сохранения изображений
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        // Сохраняем изображения на диск и добавляем пути к файлам в массив
        for image in data.allImages {
            guard let image else {
                continue
            }
            // Создаем уникальное имя файла для изображения
            let imageName = UUID().uuidString

            // Создаем путь к файлу на диске
            let imagePath = documentsDirectory.appendingPathComponent("\(imageName).png")

            // Сохраняем изображение на диск
            if let imageData = image.pngData() {
                do {
                    try imageData.write(to: imagePath)
                    // Добавляем путь к файлу в массив
                    data.imagePaths.insert(imagePath.path, at: 0)
                } catch {
                    print("Ошибка сохранения изображения на диск: \(error)")
                }
            }
        }

        // Сохраняем путь к файлу в UserDefaults
        defaults.set(data.imagePaths, forKey: data.keyForSavedImagesPaths)
        defaults.synchronize()
    }
    
    func removeAllImages(_ data: FavoriteImage) {
        defaults.removeObject(forKey: data.keyForSavedImagesPaths)
    }
    
    func loadSavedImages(_ data: FavoriteImage) {
        // Получаем массив путей к файлам из UserDefaults
        if let savedImagesPaths = UserDefaults.standard.array(forKey: data.keyForSavedImagesPaths) as? [String] {
            // Загружаем каждое изображение с диска
            for imagePath in savedImagesPaths {
                if let savedImage = UIImage(contentsOfFile: imagePath) {
                    if data.loadedImages.count < data.maxAmount {
                        data.loadedImages.append(savedImage)
                    }
                }
            }
            data.allImages = data.loadedImages
        }
    }
}
