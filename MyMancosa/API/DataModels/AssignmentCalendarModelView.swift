//
//  AssignmentCalendarModelView.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import Foundation
//AssignmentCalendar
import UIKit

protocol AssignmentCalendarViewModelItem {
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension  AssignmentCalendarViewModelItem {
    var rowCount: Int {
        return 1
    }
}

class  AssignmentCalendarViewModel: NSObject {
    var items = [AssignmentCalendarItem]()
    override init() {
        super.init()
    }
}
extension AssignmentCalendarViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: AssignmentTimeTableTableViewCell.identifier, for: indexPath) as? AssignmentTimeTableTableViewCell {
            cell.item = item
            return cell
        }
        return UITableViewCell()
    }
    
}
