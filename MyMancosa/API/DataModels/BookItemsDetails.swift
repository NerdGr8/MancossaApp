//
//  BookItemsDetails.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/17.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import Foundation
import UIKit

protocol BookItemsDetailsModelItem {
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension BookItemsDetailsModelItem {
    var rowCount: Int {
        return 1
    }
}

class BookItemsDetailsViewModel: NSObject {
    var items = [[String]]()
    override init() {
        super.init()
    }
}
extension BookItemsDetailsViewModel: UITableViewDataSource {
    
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
