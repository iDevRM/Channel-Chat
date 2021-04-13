//
//  MessageViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/23/21.
//

import UIKit

class MessageViewController: UIViewController {
     
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var loggedInUser = NetworkManager.instance.loggedInUser
    var chosenChannel: Channel?
    var messagesForChannel: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        setNavigationTitle()
        setMessages()
    }
    
    
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        if NetworkManager.instance.isLoggedIn {
            let channelId = chosenChannel!.id!
            
            SocketService.instance.addMessage(messageBody: messageTextField.text!, userId: loggedInUser!._id, channelId: channelId) { (success) in
                
                if success {
                    self.messageTextField.text = ""
                    self.setMessages()
                }
            }
        }
    }
}

extension MessageViewController: UITextFieldDelegate, UINavigationControllerDelegate {
    
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesForChannel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as? MessageTableViewCell {
            cell.configCell(for: messagesForChannel[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension MessageViewController {
    
    func setNavigationTitle() {
        if let title = chosenChannel?.name {
            navigationItem.title = "#\(title)"
        }
    }
    
    func setMessages() {
        if chosenChannel != nil {
            MessageService.instance.getAllMessages(for: chosenChannel!) { (success, messages) in
                if success {
                    self.messagesForChannel = messages
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
