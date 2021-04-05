//
//  AvatarImageCell.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/5/21.
//

import UIKit

class AvatarImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configCell(imageNumber: Int, colorSelected: Int) {
        setupView(from: colorSelected)
        if colorSelected == 0 {
            imageView.image =  UIImage(named: "light\(imageNumber)")
            } else {
                imageView.image = UIImage(named: "dark\(imageNumber)")
            }
        
        
    }
    
    func setupView(from colorSelected: Int) {
        if colorSelected == 0 {
            imageView.backgroundColor = UIColor.gray
            imageView.layer.cornerRadius = 10
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.darkGray.cgColor
        } else {
            imageView.backgroundColor = UIColor.lightGray
            imageView.layer.cornerRadius = 10
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    
}
