//
//  MessageTableViewCell.swift
//  Pods
//
//  Created by John Franklin on 9/24/15.
//
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
