//
//  ContactTableViewCell.swift
//  RiseApps
//
//  Created by Max Surgai on 27.07.17.
//  Copyright © 2017 Max Surgai. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var markImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        markImageView.layer.cornerRadius = markImageView.frame.size.height / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
