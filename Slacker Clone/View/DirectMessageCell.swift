//
//  DirectMessageCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/11/21.
//

import UIKit

class DirectMessageCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func configCell(_ cellNumber: Int) {
        switch cellNumber {
        case 0:
            icon.image = UIImage(systemName: "heart.fill")
            title.text = "Slackbot"
        case 1:
            icon.image = UIImage(systemName: "circle.fill")
            title.text = "Rick Martinez"
        case 2:
            icon.image = UIImage(systemName: "plus")
            title.text = "Add Teammates"
        default:
            break
        }
    }

}
