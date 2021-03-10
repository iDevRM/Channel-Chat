//
//  ChannelTVC.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/10/21.
//

import UIKit

class ChannelTVC: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    func configCell(_ channel: Channel) {
        name.text = channel.name
    }

}
