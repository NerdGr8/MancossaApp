//
//  BookViewModel.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import Foundation
//BookViewModel
import UIKit

protocol BookViewModelViewModelItem {
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension  BookViewModelViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class  BookViewModelViewModel: NSObject {
    var items = [BookItem]()
    override init() {
        super.init()
    }
}
extension BookViewModelViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookListingTableViewCell.identifier, for: indexPath) as? BookListingTableViewCell {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
    
}
