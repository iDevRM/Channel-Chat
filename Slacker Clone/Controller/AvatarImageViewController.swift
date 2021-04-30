//
//  AvatarImageViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/5/21.
//

import UIKit

class AvatarImageViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var chosenPicture = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor              = #colorLiteral(red: 0.4583977461, green: 0.4667810202, blue: 0.4714671373, alpha: 0.9136400033)
        collectionView.delegate           = self
        collectionView.dataSource         = self
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor    = .white
    }

    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    

}

//MARK: - Collection View Delegates and Data Source
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
            print("light\(indexPath.row)")
            UserDataService.instance.avatarName = "light\(indexPath.row)"
            
        } else {
            print("dark\(indexPath.row)")
            UserDataService.instance.avatarName = "dark\(indexPath.row)"
        }
       
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}


