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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        
    }
    
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        
        if NetworkManager.instance.isLoggedIn {
            let channelId = "605b667baeba151de2e2930d"
            
            SocketService.instance.addMessage(messageBody: messageTextField.text!, userId: loggedInUser!._id, channelId: channelId) { (success) in
                
                if success {
                    self.messageTextField.text = ""
                }
                
            }

        }
    }
    
   
}

extension MessageViewController: UITextFieldDelegate, UINavigationControllerDelegate {
    
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as? MessageTableViewCell {
            cell.configCell(message: "Default Message; fsksg iaojgiosio giofdh gifdgidsg iodfsig dgid hgdih gids gi di gifdjiog jiodf gdfigiodf gi igj ei g ire gre hilgdgheiu hgiud ghuid hgui dsugdfu gudfhgui dhsfuig sdhgui hsu gsiu Default Message; fsksg iaojgiosio giofdh gifdgidsg iodfsig dgid hgdih gids gi di gifdjiog jiodf gdfigiodf gi igj ei g ire gre hilgdgheiu hgiud ghuid hgui dsugdfu gudfhgui dhsfuig sdhgui hsu gsiu Default Message; fsksg iaojgiosio giofdh gifdgidsg iodfsig dgid hgdih gids gi di gifdjiog jiodf gdfigiodf gi igj ei g ire gre hilgdgheiu hgiud ghuid hgui dsugdfu gudfhgui dhsfuig sdhgui hsu gsiu Default Message; fsksg iaojgiosio giofdh gifdgidsg iodfsig dgid hgdih gids gi di gifdjiog jiodf gdfigiodf gi igj ei g ire gre hilgdgheiu hgiud ghuid hgui dsugdfu gudfhgui dhsfuig sdhgui hsu gsiu", user: loggedInUser!)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
