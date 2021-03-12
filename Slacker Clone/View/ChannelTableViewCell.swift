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

}
