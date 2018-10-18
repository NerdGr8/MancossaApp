//
//  ProfileAtrribute.swift
//  Topix
//
//  Created by Nerudo Mregi on 2018/04/02.
//  Copyright © 2018 Topix Developer. All rights reserved.
//

import UIKit

class ProfileAtrribute: UITableViewCell {

    @IBOutlet weak var Title: UILabel?
    @IBOutlet weak var Value: UILabel?
    var item: [String]?  {
        didSet {
            Title?.text = item?[0]
            Value?.text = item?[1]
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
