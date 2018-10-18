//
//  AnnouncementModelView.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
import Foundation
import UIKit

protocol AnnouncementViewModelItem {
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension AnnouncementViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class AnnouncementViewModel: NSObject {
    var items = [String]()
    override init() {
        super.init()
    }
}
extension AnnouncementViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.identifier, for: indexPath) as? AnnouncementTableViewCell {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
    
}
