//
//  SecondViewController.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 29/5/23.
//

import UIKit

class SecondViewController: UIViewController {
    let favoriteView = FavoriteView()
    let cellIdentifier = "ImageCell"
    var favorites = FavoriteImage(maxAmount: 10)
    
    // Создаем массив для хранения путей к файлам изображений
    var imagePaths: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Second"
        
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(favoriteView.tableView)
        
        favoriteView.setupConstraints(view)
        loadSavedImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
    }
    
    private func updateTableView() {
        favoriteView.tableView.reloadData()
    }
    
    private func saveImages() {
        // Получаем путь к директории для сохранения изображений
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        // Сохраняем изображения на диск и добавляем пути к файлам в массив
        for image in favorites.allImages {
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
                    imagePaths.insert(imagePath.path, at: 0)
                } catch {
                    print("Ошибка сохранения изображения на диск: \(error)")
                }
            }
        }

        // Сохраняем путь к файлу в UserDefaults
        UserDefaults.standard.set(imagePaths, forKey: "SavedImagesPaths")
    }
    
    private func loadSavedImages() {
        // Получаем массив путей к файлам из UserDefaults
        if let savedImagesPaths = UserDefaults.standard.array(forKey: "SavedImagesPaths") as? [String] {
            // Загружаем каждое изображение с диска
            var loadedImages: [UIImage] = []
            for imagePath in savedImagesPaths {
                if let savedImage = UIImage(contentsOfFile: imagePath) {
                    loadedImages.append(savedImage)
                }
            }
            if favorites.allImages.isEmpty {
                favorites.allImages = loadedImages
            }
            print(savedImagesPaths)
        }
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.allImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = favorites.allImages[indexPath.row]
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width - 30
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.allImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try FileManager.default.removeItem(atPath: imagePaths[indexPath.row])
                imagePaths.remove(at: indexPath.row)
                print("Изображение удалено успешно")
            } catch {
                print("Ошибка удаления изображения: \(error)")
            }
        }
    }
    
}

extension SecondViewController: ImageDelegate {
    func addImageToFavorites(_ image: UIImage) {
        if favorites.allImages.count < favorites.maxAmount {
            favorites.allImages.insert(image, at: 0)
            updateTableView()
            print(favorites.allImages.count)
        } else {
            favorites.allImages.insert(image, at: 0)
            favorites.allImages.removeLast()
            imagePaths.removeLast()
        }
        saveImages()
    }
}
