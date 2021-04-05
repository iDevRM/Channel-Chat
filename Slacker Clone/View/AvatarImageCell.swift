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
        setupView()
        imageView.image = UIImage(named: imageName)
        
    }
    
    func setupView() {
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
}
