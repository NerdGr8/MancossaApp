//
//  CustomTabBarItem.swift
//  Task Studio
//
//  Created by Nerudo Mregi on 2017/02/23.
//  Copyright © 2017 NM. All rights reserved.
//

import UIKit
import SwiftIcons
class CustomTabBarItem: UIView {
    
    var iconView: UIImageView!
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(item: UITabBarItem) {
        var image = UIImage.init(icon: .ionicons(.search), size: CGSize(width: 25, height: 25))
        if item.title == "Announcements" {
            image = UIImage.init(icon:.linearIcons(.alarm), size: CGSize(width: 28, height: 28))
        }
        if item.title == "Books" {
            image = UIImage.init(icon: .linearIcons(.book), size: CGSize(width: 28, height: 28))
        }
        else if item.title == "Calendar" {
            image = UIImage.init(icon:.linearIcons(.calendarFull), size: CGSize(width: 28, height: 28))
        }
        else if item.title == "Profile" {
            image = UIImage.init(icon: .linearIcons(.user), size: CGSize(width: 28, height: 28))
        }
        // create imageView centered within a container
        iconView = UIImageView(frame: CGRect(x: (self.frame.width-image.size.width)/2, y: (self.frame.height-image.size
            .height)/2, width: self.frame.width, height: self.frame.height))
        
        iconView.image = image
        iconView.sizeToFit()
        
        self.addSubview(iconView)
    }
    
}
