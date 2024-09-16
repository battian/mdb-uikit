//
//  TabBarViewController.swift
//  MDB
//
//  Created by Ana Battistini on 02/08/24.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabs()
    configureNavigationBar()
  }
  
  private func configureTabs() {
    let vc1 = HomeViewController()
    let vc2 = FavoritesMoviesViewController()
    
    vc1.tabBarItem.image = UIImage(systemName: "house")
    vc2.tabBarItem.image = UIImage(systemName: "heart")
    
    vc1.title = "Home"
    vc2.title = "Favorites"
    
    let nav1 = UINavigationController(rootViewController: vc1)
    let nav2 = UINavigationController(rootViewController: vc2)
    
    tabBar.tintColor = .systemPurple
    tabBar.backgroundColor = .systemGray6
    
    setViewControllers([nav1, nav2], animated: true)
  }
  
  func configureNavigationBar() {
    UINavigationBar.appearance().tintColor = .systemPurple
  }
  
}
