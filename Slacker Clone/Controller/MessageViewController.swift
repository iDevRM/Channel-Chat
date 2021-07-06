//
//  MessageViewController.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/23/21.
//

import UIKit

class MessageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var typingUsersLabel: UILabel!
    
    var loggedInUser = NetworkManager.instance.loggedInUser
    var chosenChannel: Channel?
    var messagesForChannel: [Message] = []
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIAndDelegates()
        setNavigationTitle()
        setMessages()
        listenForNewMessages()
        listenForTypingUsers()
        hideKeyboardFromOutsideTap()
    }
    
    
    
//MARK: - IBActions / API calls
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard messageTextField.hasText else { return }
        
        if NetworkManager.instance.isLoggedIn {
            let channelId = chosenChannel!.id!
            
            SocketService.instance.addMessage(messageBody: messageTextField.text!, userId: loggedInUser!._id, channelId: channelId) { (success) in
                
                if success {
                    self.messageTextField.text = ""
                    self.setMessages()
                    if let userName = self.loggedInUser?.name {
                        socket.emit("stopType", userName)
                    }
                }
            }
        }
    }
}

//MARK: - Text Field Delegate / Navigation Controller Delegate
extension MessageViewController: UITextFieldDelegate, UINavigationControllerDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped(UIButton())
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let channelId = chosenChannel?.id,
              let userName = loggedInUser?.name else { return }
        
        if !textField.hasText {
            isTyping = false
            socket.emit("stopType", userName)
        } else {
            if !isTyping {
                socket.emit("startType", userName, channelId)
            }
            isTyping = true
        }
        
    }
    
}

//MARK: - Table View Delegate and Data Source
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

//MARK: - Socket Services
extension MessageViewController {
    
    func setMessages() {
        if chosenChannel != nil {
            MessageService.instance.getAllMessages(for: chosenChannel!) { (success, messages) in
                if success {
                    self.messagesForChannel = messages
                    self.tableView.reloadData()
                    if self.messagesForChannel.count > 0 {
                        let indexPath = IndexPath(row: self.messagesForChannel.count - 1, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
        }
        
    }
    
    func listenForNewMessages() {
        SocketService.instance.getNewMessage { (newMessage) in
            if newMessage.channelId == self.chosenChannel?.id {
                self.setMessages()
                
            }
        }
        
    }
    
    func listenForTypingUsers() {
        SocketService.instance.getTypingUsers { (typingUsers) in
            
            guard let channelId = self.chosenChannel?.id,
                  let userName = self.loggedInUser?.name else { return }
            
            var names          = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != userName && channel == channelId {
                    if names.isEmpty {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLabel.text = "\(names) \(verb) typing a message..."
            } else {
                self.typingUsersLabel.text = ""
            }
        }
    }
    
}

//MARK: - Helper Functions
extension MessageViewController {
    
    func hideKeyboardFromOutsideTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setNavigationTitle() {
        if let title = chosenChannel?.name {
            navigationItem.title = "#\(title)"
        }
    }
    
    func setUIAndDelegates() {
        tableView.delegate                 = self
        tableView.dataSource               = self
        messageTextField.delegate          = self
        messageTextField.layer.borderWidth = 0.3
        messageTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
}
