//
//  AvatarImageCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/5/21.
//

import UIKit

class AvatarImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configCell(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
}
