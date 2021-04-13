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
    
    func configCell(for message: Message) {
        messageLabel.text = message.body
        avatarImage.image = UIImage(systemName: "person")
        nameLabel.text = message.userName
    }

}
