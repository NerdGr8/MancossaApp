
//
//  CustomTabBar.swift
//  Task Studio
//
//  Created by Nerudo Mregi on 2017/02/23.
//  Copyright © 2017 NM. All rights reserved.
//

import UIKit
protocol CustomTabBarDataSource {
    func tabBarItemsInCustomTabBar(tabBarView: CustomTabBar) -> [UITabBarItem]
}
protocol CustomTabBarDelegate {
    func didSelectViewController(tabBarView: CustomTabBar, atIndex index: Int)
}

class CustomTabBar: UIView {
    var delegate: CustomTabBarDelegate!
    var datasource: CustomTabBarDataSource!
    var tabBarItems: [UITabBarItem]!
    
    var customTabBarItems: [CustomTabBarItem]!
    var tabBarButtons: [UIButton]!
    
    var initialTabBarItemIndex: Int!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.flatWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func barItemTapped(sender : UIButton) {
        let index = tabBarButtons.index(of: sender)!
        print(index)
        tabBarButtons[index].tintColor = UIColor.flatLime
        
        delegate.didSelectViewController(tabBarView: self, atIndex: index)
        print("tapped")
    }
    func setup() {
        // get tab bar items from default tab bar
        tabBarItems = datasource.tabBarItemsInCustomTabBar(tabBarView: self)
        customTabBarItems = []
        tabBarButtons = []
        let containers = createTabBarItemContainers()
        createTabBarItems(containers: containers)

    }
    func createTabBarItems(containers: [CGRect]) {
        
        var index = 0
        for item in tabBarItems {
            
            let container = containers[index]
            
            let customTabBarItem = CustomTabBarItem(frame: container)
            customTabBarItem.setup(item: item)
            
            self.addSubview(customTabBarItem)
            customTabBarItems.append(customTabBarItem)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: container.width, height: container.height))
            button.addTarget(self, action: #selector(barItemTapped(sender:)), for: UIControlEvents.touchUpInside)
            
            customTabBarItem.addSubview(button)
            tabBarButtons.append(button)
            
            index+=1
        }
    }
    func createTabBarItemContainers() -> [CGRect] {
        
        var containerArray = [CGRect]()
        
        // create container for each tab bar item
        for index in 0..<tabBarItems.count {
            let tabBarContainer = createTabBarContainer(index: index)
            containerArray.append(tabBarContainer)
        }
        
        return containerArray
    }
    
    func createTabBarContainer(index: Int) -> CGRect {
        
        let tabBarContainerWidth = self.frame.width / CGFloat(tabBarItems.count)
        let tabBarContainerRect = CGRect(x: tabBarContainerWidth * CGFloat(index), y: 0, width: tabBarContainerWidth, height: self.frame.height)
        
        return tabBarContainerRect
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
