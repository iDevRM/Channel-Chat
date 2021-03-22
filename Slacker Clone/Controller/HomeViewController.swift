//
//  HomeViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar:         UISearchBar!
    @IBOutlet weak var channelsTableView: UITableView!
    @IBOutlet weak var button:            UIButton!

    
    var placeHolderData = [Channel(name: "apple-events"),Channel(name: "beginner-questions"),Channel(name: "career-advice"),Channel(name: "course-github-followers"),Channel(name: "general"),Channel(name: "resources")]

    override func viewDidLoad() {
        super.viewDidLoad()
        channelsTableView.delegate   = self
        channelsTableView.dataSource = self
        button.layer.cornerRadius    = 25
    }
    override func viewWillAppear(_ animated: Bool) {
        if let user = NetworkManager.instance.loggedInUser {
            navigationItem.title = "\(user.name )'s channel"
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolderData.count + 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func createCell(withIndentifier: String, imageName: String?, title: String, color: UIColor?) -> UITableViewCell {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(withIndentifier)") as? ChannelTableViewCell {
                
                if imageName != nil {
                    cell.configCell(imageName: "\(imageName!)", title: "\(title)")
                } else {
                    cell.configCell(imageName: nil, title: "\(title)")
                }
                
                if color != nil {
                    cell.thumbnail.tintColor = color
                }
                
                return cell
                
            }
            
            return UITableViewCell()
            
        }
        
        switch indexPath.row {
        case 0:
            return createCell(withIndentifier: "channelCell", imageName: "square.stack.3d.down.right", title: "Threads", color: nil)
        case 1:
            return createCell(withIndentifier: "dividerCell", imageName: nil, title: "Channels", color: nil)
        case 8:
            return createCell(withIndentifier: "dividerCell", imageName: nil, title: "Direct Messages", color: nil)
        case 9:
            return createCell(withIndentifier: "channelCell", imageName: "heart.fill", title: "Slackbot", color: #colorLiteral(red: 0.4048334956, green: 0.745326519, blue: 0.2040545642, alpha: 1))
        case 10:
            return createCell(withIndentifier: "channelCell", imageName: "circle.fill", title: "Rick Martinez", color: #colorLiteral(red: 0.4048334956, green: 0.745326519, blue: 0.2040545642, alpha: 1))
        case 11:
            return createCell(withIndentifier: "channelCell", imageName: "plus", title: "Add teammates", color: nil)
        default:
            return createCell(withIndentifier: "channelCell", imageName: "number", title: "\(placeHolderData[indexPath.row - 2].name)", color: nil)
        }
    }
}
