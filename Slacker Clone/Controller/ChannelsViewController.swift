//
//  HomeViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/10/21.
//

import UIKit

class ChannelsViewController: UIViewController {
    
    @IBOutlet weak var searchBar:           UISearchBar!
    @IBOutlet weak var channelsTableView:   UITableView!
    @IBOutlet weak var button:              UIButton!
    @IBOutlet weak var addChannelBarButton: UIBarButtonItem!
    
    var channelSelected: Channel?
    var placeHolderChannels = [Channel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        channelsTableView.delegate   = self
        channelsTableView.dataSource = self
        button.layer.cornerRadius    = 25
        setNaviationTitle()
        setChannels()
        listenForNewChannels()
        SocketService.instance.getNewMessage { (newMessage) in
            let index = self.placeHolderChannels.firstIndex { $0.id == newMessage.channelId }!
            self.placeHolderChannels[index].hasNewMessage = true
            self.channelsTableView.reloadData()
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? MessageViewController {
            if channelSelected != nil {
                destVC.chosenChannel = channelSelected
            }
        }
    }
    
    
    @IBAction func addChannelTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Channel", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Channel name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Channel description"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if alert.textFields != nil {
                
                if let channelName = alert.textFields?[0].text, let channelDescription = alert.textFields?[1].text {
                    
                    SocketService.instance.addChannel(name: channelName, description: channelDescription) { (success) in
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)

    }
    
    
}

extension ChannelsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeHolderChannels.count + 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        func createInactiveCell(withIndentifier: String, imageName: String?, title: String, color: UIColor?) -> UITableViewCell {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: withIndentifier ) as? ChannelTableViewCell {
                
                if imageName != nil {
                    cell.configCell(imageName: imageName!, title: title)
                } else {
                    cell.configCell(imageName: nil, title: title)
                }
                
                if color != nil {
                    cell.thumbnail.tintColor = color
                }
                return cell
            }
            return UITableViewCell()
        }
        
        
        func createActiveCell(channel: Channel) -> UITableViewCell {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell") as? ChannelTableViewCell {
                cell.configActiveCell(channel: channel)
                return cell
            }
            
            return UITableViewCell()
            
        }
        
        switch indexPath.row {
        case 0:
            return createInactiveCell(withIndentifier: "channelCell", imageName: "square.stack.3d.down.right", title: "Threads", color: nil)
        case 1:
            return createInactiveCell(withIndentifier: "dividerCell", imageName: nil, title: "Channels", color: nil)
        case placeHolderChannels.count + 2:
            return createInactiveCell(withIndentifier: "dividerCell", imageName: nil, title: "Direct Messages", color: nil)
        case placeHolderChannels.count + 3:
            return createInactiveCell(withIndentifier: "channelCell", imageName: "heart.fill", title: "Slackbot", color: #colorLiteral(red: 0.4048334956, green: 0.745326519, blue: 0.2040545642, alpha: 1))
        case placeHolderChannels.count + 4:
            return createInactiveCell(withIndentifier: "channelCell", imageName: "circle.fill", title: "Rick Martinez", color: #colorLiteral(red: 0.4048334956, green: 0.745326519, blue: 0.2040545642, alpha: 1))
        case placeHolderChannels.count + 5:
            return createInactiveCell(withIndentifier: "channelCell", imageName: "plus", title: "Add teammates", color: nil)
        default:
            return createActiveCell(channel: placeHolderChannels[indexPath.row - 2])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (indexPath.row - 2) >= 0, (indexPath.row - 2) < placeHolderChannels.count else { return }
        
        channelSelected = placeHolderChannels[indexPath.row - 2]
        placeHolderChannels[indexPath.row - 2].hasNewMessage = false
        performSegue(withIdentifier: "ToMessageVC", sender: nil)
        channelsTableView.reloadData()
        
    }
}

extension ChannelsViewController {
    func setNaviationTitle() {
        if let user = NetworkManager.instance.loggedInUser {
            navigationItem.title = "\(user.name )'s channel"
        }
    }
    
    func setChannels() {
        MessageService.instance.findAllChannels { (success) in
            self.placeHolderChannels.removeAll()
            for channel in MessageService.instance.channels {
                self.placeHolderChannels.append(channel)
            }
            self.channelsTableView.reloadData()
        }
    }
    
    func listenForNewChannels() {
        SocketService.instance.getChannel { (success) in
            if success {
                self.setChannels()
            }
        }
    }
}
