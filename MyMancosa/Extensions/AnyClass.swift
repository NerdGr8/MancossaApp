//
//  AnyClass.swift
//  Topix
//
//  Created by Nerudo Mregi on 2018/04/22.
//  Copyright © 2018 NM Apps. All rights reserved.
//

import Foundation
import UIKit
class AnyClass{
    class func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    class func alert(message:String){
        let alert=UIAlertController(title: "Hey!", message: message, preferredStyle: .alert);
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            
        }
        alert.addAction(cancelAction)
        AnyClass.topMostController().present(alert, animated: true, completion: nil);
    }
}
