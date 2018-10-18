//
//  MyProfileVC.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/15.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class MyProfileVC: UIViewController {
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    @IBOutlet weak var tableView: UITableView!
    fileprivate let viewModel = MyProfileAttributesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = viewModel
        self.activityIndicatorView.startAnimating()
        loadMyProfile()
        tableView?.register(ProfileAtrribute.nib, forCellReuseIdentifier: ProfileAtrribute.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear;
        // Do any additional setup after loading the view.
    }
    func loadMyProfile(){
        self.viewModel.items = []
        API.sharedInstance.myprofile(completion: { (json) in
            let items = json["data"] as! NSArray
            print(items)
            for item in items {
                if let assTemp = item as? [String] {
                    self.viewModel.items.append(assTemp)
                }
            }
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        })
    }
    

}
