//
//  MainTBVC.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/15.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class MainTBVC: UITabBarController, CustomTabBarDataSource, CustomTabBarDelegate {
    public var customTabBar : CustomTabBar? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.hidesNavigationBarHairline = true
        
        // Dispose of any resources that can be recreated.
        customTabBar = CustomTabBar(frame: self.tabBar.frame)
        customTabBar?.datasource = self
        customTabBar?.delegate = self
        customTabBar?.setup()
        tabBarController?.selectedIndex=1
        
        self.tabBar.isHidden = true
        self.view.addSubview(customTabBar!)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        customTabBar = CustomTabBar(frame: self.tabBar.frame)
        customTabBar?.datasource = self
        customTabBar?.delegate = self
        customTabBar?.setup()
        tabBarController?.selectedIndex = 1
        
        self.tabBar.isHidden = true
        self.view.addSubview(customTabBar!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: - CustomTabBarDataSource
    
    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    func didSelectViewController(tabBarView: CustomTabBar, atIndex index: Int) {
        self.selectedIndex = index
    }
    

}
