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
    
    func configCell(_ imageName: String, title: String) {
        label.text = title
        thumbnail.image = UIImage(systemName: "\(imageName)")
    }

}
