//
//  SecondViewController.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 29/5/23.
//

import UIKit

protocol ImageDelegate: AnyObject {
    func sendImage(_ image: UIImage)
}

var images = FavoriteImage.getAllFavoriteImages

class SecondViewController: UIViewController {
    let favoriteView = FavoriteView()
    let cellIdentifier = "ImageCell"
    
    weak var delegate: ImageDelegate?
    
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
    
    func updateTableView() {
        // Обновление таблицы
        favoriteView.tableView.reloadData()
        print("In TV have \(images.count)")
    }
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.imageView?.image = images[indexPath.row]
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width - 30
    }
}
