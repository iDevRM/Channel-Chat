//
//  HomeViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button:    UIButton!
    
    var placeHolderData = [Channel(name: "apple-events"),Channel(name: "beginner-questions"),Channel(name: "career-advice"),Channel(name: "course-github-followers"),Channel(name: "general"),Channel(name: "resources")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        button.layer.cornerRadius = 25
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelsCell") as? ChannelTVC {
            cell.configCell(placeHolderData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}
