//
//  BooksVC.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class BooksVC: UIViewController, UITableViewDelegate {
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
    fileprivate let viewModel = BookViewModelViewModel()
    
    @IBOutlet weak var nsvBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addBook))
        //addButton.setIcon(icon: .linearIcons(.fileAdd), iconSize: 30)
        self.navigationItem.rightBarButtonItem = addButton
        
        tableView?.dataSource = viewModel
        self.activityIndicatorView.startAnimating()
        loadBooks()
        tableView?.register(BookListingTableViewCell.nib, forCellReuseIdentifier: BookListingTableViewCell.identifier)
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView.separatorColor = UIColor.clear;
        // Do any additional setup after loading the view.
    }
    func loadBooks(){
        self.viewModel.items = []
        API.sharedInstance.books(completion: { (json) in
            let items = json["data"] as! NSArray
            for item in items {
                if let _item = item as? [String: Any] {
                    let calItem = BookItem(sNo: _item[BookItemKeys.sNo.rawValue] as! String,
                                           subjectName: _item[BookItemKeys.subjectName.rawValue] as! String,
                                           bookTitle: _item[BookItemKeys.bookTitle.rawValue] as! String,
                                           authorName: _item[BookItemKeys.authorName.rawValue] as! String,
                                           publications: _item[BookItemKeys.publications.rawValue] as! String,
                                           view: _item[BookItemKeys.view.rawValue] as! String)
                    self.viewModel.items.append(calItem)
                }
            }
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        })
    }
    @objc func addBook(){
        //
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectSelectedRow(animated: true)
        let item =  self.viewModel.items[indexPath.row]
        let popupVC:BookDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookDetailsVC") as! BookDetailsVC
        popupVC.book = item
        popupVC.modalPresentationStyle = UIModalPresentationStyle .popover
        popupVC.preferredContentSize = CGSize(width: tableView.frame.width, height: (view.frame.height))
        popupVC.popoverPresentationController?.delegate = tableView.inputViewController as? UIPopoverPresentationControllerDelegate
        self.present(popupVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
