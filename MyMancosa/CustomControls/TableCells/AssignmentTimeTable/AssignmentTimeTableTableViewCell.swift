//
//  AssignmentTimeTableTableViewCell.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class AssignmentTimeTableTableViewCell: UITableViewCell {

    @IBOutlet weak var CourseTitle: UILabel!
    @IBOutlet weak var DueDate: UILabel!
    var item: AssignmentCalendarItem? {
        didSet {
            guard let item = item else {
                return
            }
            CourseTitle?.text = item.moduleName
            DueDate.text = item.dueDate
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
