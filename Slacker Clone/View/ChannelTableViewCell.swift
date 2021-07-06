//
//  ChannelTableViewCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/11/21.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    func configCell(imageName: String?, title: String) {
        label.text = title
        if imageName != nil {
            thumbnail.image = UIImage(systemName: "\(imageName!)")
        }
    }
    
    func configActiveCell(channel: Channel) {
        label.text = channel.name
        thumbnail.image = UIImage(systemName: "number")
        thumbnail.tintColor = UIColor.gray
        
        if let unreadChannel = channel.hasNewMessage {
            if unreadChannel {
                label.font = UIFont(name: "AvenirNext-Bold", size: 14)
            } else {
                label.font = UIFont(name: "AvenirNext-Medium", size: 14)
            }
        }
    }

}
