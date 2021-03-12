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
        return placeHolderData.count + 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell {
                cell.configCell(imageName: "square.stack.3d.down.right", title: "Threads")
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "dividerCell") as? ChannelTableViewCell {
                cell.configCell(imageName: nil, title: "Channels")
                return cell
            }
        } else if indexPath.row == 8 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "dividerCell") as? ChannelTableViewCell {
                cell.configCell(imageName: nil, title: "Direct Messages")
                return cell
            }
        } else if indexPath.row == 9 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell {
                cell.configCell(imageName: "heart.fill", title: "Slackbot")
                return cell
            }
        } else if indexPath.row == 10 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell {
                cell.configCell(imageName: "circle.fill", title: "Rick Martinez")
                return cell
            }
        } else if indexPath.row == 11 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell {
                cell.configCell(imageName: "plus", title: "Add teammates")
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell {
                cell.configCell(imageName: "number", title: placeHolderData[indexPath.row - 2].name)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
}
