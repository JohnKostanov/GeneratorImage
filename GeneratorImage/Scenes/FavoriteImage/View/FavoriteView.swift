//
//  FavoriteView.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 30/5/23.
//

import UIKit

class FavoriteView {
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    func setupConstraints(_ view: UIView) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
