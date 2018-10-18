//
//  BookListingTableViewCell.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/16.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import UIKit

class BookListingTableViewCell: UITableViewCell {

    @IBOutlet weak var Publisher: UILabel!
    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var IconAuthor: UIImageView!
    var item: BookItem? {
        didSet {
            guard let item = item else {
                return
            }
            Publisher?.text = item.publications
            BookTitle.text = item.bookTitle
            Author.text = item.authorName
            Author.textColor = UIColor(hex: "#3AD29F") //UIColor(hex: "#24B6F7")
            IconAuthor.image = UIImage(icon: .linearIcons(.user), size: CGSize(width: 18, height: 18), textColor: UIColor(hex: "#24B6F7"), backgroundColor: UIColor.clear)
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
