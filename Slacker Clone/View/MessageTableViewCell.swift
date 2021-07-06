//
//  MessageTableViewCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/23/21.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage:  UIImageView!
    @IBOutlet weak var nameLabel:    UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel:    UILabel!
    
    func configCell(for message: Message) {
        messageLabel.text              = message.body
        avatarImage.image              = UIImage(named: message.userAvatarName)
        avatarImage.backgroundColor    = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        nameLabel.text                 = message.userName
        formatMessageTime(message)
    }
    
    func formatMessageTime(_ message: Message) {
        let isoDate   = message.time
        let end       = isoDate.firstIndex(of: ".")
        let substring = isoDate[..<end!]
        
        let isoFormatter = ISO8601DateFormatter()
        let messageDate  = isoFormatter.date(from: substring.appending("Z"))
        
        let newFormatter        = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate   = messageDate {
            let finalDate  = newFormatter.string(from: finalDate)
            timeLabel.text = finalDate
        }
    }

}
