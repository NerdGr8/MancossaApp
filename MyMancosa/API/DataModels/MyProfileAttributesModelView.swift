//
//  AnnouncementModelView.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
import Foundation
import UIKit

protocol MyProfileAttributesModelItem {
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension MyProfileAttributesModelItem {
    var rowCount: Int {
        return 1
    }
}

class MyProfileAttributesViewModel: NSObject {
    var items = [[String]]()
    override init() {
        super.init()
    }
}
extension MyProfileAttributesViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileAtrribute.identifier, for: indexPath) as? ProfileAtrribute {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
    
}
