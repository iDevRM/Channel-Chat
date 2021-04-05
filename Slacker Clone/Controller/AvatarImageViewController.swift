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
        view.backgroundColor = #colorLiteral(red: 0.7346229553, green: 0.7302576303, blue: 0.7379794717, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
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
            cell.configCell(imageNumber: indexPath.row, colorSelected: segmentControl.selectedSegmentIndex)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            NetworkManager.instance.loggedInUser?.avatarName = "light\(indexPath.row)"
        } else {
            NetworkManager.instance.loggedInUser?.avatarName = "dark\(indexPath.row)"
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    
}


