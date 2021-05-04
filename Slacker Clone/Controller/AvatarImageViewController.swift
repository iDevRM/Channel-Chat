//
//  AvatarImageViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/5/21.
//

import UIKit

//MARK: - Protocols
protocol ImageSelecterDelegate {
    func setNewImage(image: String, backgroundColor: UIColor )
}
//MARK: - ViewController
class AvatarImageViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    var imageDelegate: ImageSelecterDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor              = #colorLiteral(red: 0.4583977461, green: 0.4667810202, blue: 0.4714671373, alpha: 0.9136400033)
        collectionView.delegate           = self
        collectionView.dataSource         = self
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor    = .white
    }

//MARK: - IBActions
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
}

//MARK: - Collection View Delegate and Data Source
extension AvatarImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarImageCell {
            
            cell.configCell(imageNumber: indexPath.row, colorSelected: segmentControl.selectedSegmentIndex)
            
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if segmentControl.selectedSegmentIndex == 0 {
           
            imageDelegate.setNewImage(image: "light\(indexPath.row)", backgroundColor: UIColor.gray)
            UserDataService.instance.avatarName = "light\(indexPath.row)"
            
        } else {
            
            imageDelegate.setNewImage(image: "dark\(indexPath.row)", backgroundColor: UIColor.lightGray)
            UserDataService.instance.avatarName = "dark\(indexPath.row)"
        }
       
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}


