//
//  AvatarImageViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/5/21.
//

import UIKit

class AvatarImageViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
    }

    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    

}

extension AvatarImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarImageCell {
            if segmentControl.selectedSegmentIndex == 0 {
                cell.configCell(imageName: "light\(indexPath.row)")
                return cell
            } else {
                cell.configCell(imageName: "dark\(indexPath.row)")
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    
}


