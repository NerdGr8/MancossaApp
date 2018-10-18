//
//  AnnouncementTableViewCell.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class AnnouncementTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAnnouncement: UILabel!
    var item: String? {
        didSet {
            guard let item = item else {
                return
            }
            lblAnnouncement?.text = item
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundView?.layer.borderWidth = 2;
        self.backgroundView?.layer.borderColor = UIColor(hex: "#E8E8E8").cgColor;
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
