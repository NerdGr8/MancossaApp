//
//  BookDetailsVC.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/17.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class BookDetailsVC: UIViewController {
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
    var book : BookItem? = nil
    fileprivate let viewModel = BookItemsDetailsViewModel()
    
   //.setImage(UIImage.init(icon: .ionicons(.iosPlus), size: CGSize(width: 30, height: 30)), for: UIControlState.normal)
    
    @IBOutlet weak var lblFilterBySubject: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var callOwner: UIButton!
    
    @IBAction func Close(_ sender: Any) {
        let tabVC:MainTBVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTBVC") as! MainTBVC
        //popupVC.topic_id = 10
        tabVC.selectedIndex = 2
        self.present(tabVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = viewModel
        self.activityIndicatorView.startAnimating()
        loadBookDetails()
        tableView?.register(ProfileAtrribute.nib, forCellReuseIdentifier: ProfileAtrribute.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear;
        backBtn.setImage(UIImage.init(icon: .ionicons(.iosArrowBack), size: CGSize(width: 30, height: 30)), for: UIControlState.normal)
        callOwner.setImage(UIImage.init(icon: .ionicons(.androidCall), size: CGSize(width: 30, height: 30)), for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }
    func loadBookDetails(){
        self.viewModel.items = []
        API.sharedInstance.bookDetails(view: (book?.view)!, completion: { (json) in
            let items = json["data"] as! NSArray
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
