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
    @IBOutlet weak var timeLabel: UILabel!
    
    func configCell(for message: Message) {
        messageLabel.text = message.body
        avatarImage.image = UIImage(named: "profileDefault")
        nameLabel.text = message.userName
        
        var isoDate = message.time
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        let substring = isoDate.removeSubrange(end as RangeExpression)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: substring.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeLabel.text = finalDate
        }
        
    }

}
