//
//  TabBarController.swift
//  GeneratorImage
//
//  Created by Джон Костанов on 29/5/23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем два контроллера представления для каждого таба
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        firstVC.delegate = secondVC
        
        // Устанавливаем контроллеры представления в таб-бар
        setViewControllers([firstVC, secondVC], animated: false)
        
        // Настраиваем заголовки для каждого таба
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }
}
