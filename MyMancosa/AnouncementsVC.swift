//
//  AssignmentsViewController.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/15.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class AnouncementsVC: UIViewController, UITableViewDelegate{
    fileprivate lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        
        // Set Center
        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    @IBOutlet weak var tableView: UITableView!
    fileprivate let viewModel = AnnouncementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = viewModel
        self.activityIndicatorView.startAnimating()
        loadAnnouncements()
        tableView?.register(AnnouncementTableViewCell.nib, forCellReuseIdentifier: AnnouncementTableViewCell.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear;
        // Do any additional setup after loading the view.
    }
    func loadAnnouncements(){
        API.sharedInstance.announcements(completion: { (json) in
            //print(json["data"])
            self.viewModel.items = []
            self.viewModel.items = (json["data"] as! NSArray) as! [String]
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
