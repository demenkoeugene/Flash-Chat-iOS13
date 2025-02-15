//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Eugene Demenko on 23.10.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
