//
//  HomeViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var channelsTableView: UITableView!
    @IBOutlet weak var button:    UIButton!
    @IBOutlet weak var threadsTableView: UITableView!
    @IBOutlet weak var directMessagesTableView: UITableView!
    
    var placeHolderData = [Channel(name: "apple-events"),Channel(name: "beginner-questions"),Channel(name: "career-advice"),Channel(name: "course-github-followers"),Channel(name: "general"),Channel(name: "resources")]

    override func viewDidLoad() {
        super.viewDidLoad()
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        
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
