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
        }
    }
}
