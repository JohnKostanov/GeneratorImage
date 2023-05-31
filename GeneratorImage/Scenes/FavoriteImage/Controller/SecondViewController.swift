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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Second"
        
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(favoriteView.tableView)
        
        favoriteView.setupConstraints(view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
    }
    
    private func updateTableView() {
        favoriteView.tableView.reloadData()
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.allFavoriteImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = favorites.allFavoriteImages[indexPath.row]
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width - 30
    }
}

extension SecondViewController: ImageDelegate {
    func addImageToFavorites(_ image: UIImage) {
        if favorites.allFavoriteImages.count < favorites.maxAmount {
            favorites.allFavoriteImages.insert(image, at: 0)
            updateTableView()
            print(favorites.allFavoriteImages.count)
        } else {
            favorites.allFavoriteImages.insert(image, at: 0)
            favorites.allFavoriteImages.removeLast()
        }
    }
}
