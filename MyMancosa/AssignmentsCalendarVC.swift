//
//  AssignmentsCalendarVC.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/15.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class AssignmentsCalendarVC: UIViewController, UITableViewDelegate {
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
    fileprivate let viewModel = AssignmentCalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = viewModel
        self.activityIndicatorView.startAnimating()
        loadAnnouncements()
        tableView?.register(AssignmentTimeTableTableViewCell.nib, forCellReuseIdentifier: AssignmentTimeTableTableViewCell.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear;
        // Do any additional setup after loading the view.
    }
    func loadAnnouncements(){
        self.viewModel.items = []
        API.sharedInstance.assignmentsCalendar(completion: { (json) in
            let items = json["data"] as! NSArray
            for item in items {
                if let assTemp = item as? [String: Any] {
                    let calItem = AssignmentCalendarItem(
                        programmeName: assTemp["ProgrammeName"] as! String,
                        intake: assTemp["Intake"] as! String,
                        year: assTemp["Year"] as! String,
                        assignmentNo: assTemp["AssignmentNo"] as! String,
                        moduleName: assTemp["ModuleName"] as! String,
                        dueDate: assTemp["DueDate"] as! String,
                        remark: assTemp["Remark"] as! String)
                    
                    self.viewModel.items.append(calItem)
                }
            }
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
