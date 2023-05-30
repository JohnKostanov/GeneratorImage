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
    let cellSpacing: CGFloat = 20
    
    let images: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!]
    
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
