//
//  MessageTableViewCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/23/21.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    func configCell(message: String, user: User) {
        messageLabel.text = message
        avatarImage.image = UIImage(systemName: "person")
        nameLabel.text = user.name
    }

}
