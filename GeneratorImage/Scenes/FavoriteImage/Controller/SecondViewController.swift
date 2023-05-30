//
//  SecondViewController.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 29/5/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let cellIdentifier = "ImageCell"
    let cellSpacing: CGFloat = 20
    
    let images: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Second"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
