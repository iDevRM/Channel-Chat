//
//  SocketService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/22/21.
//

import Foundation
import SocketIO




    
class SocketService: NSObject {
    
    let manager = SocketManager(socketURL: URL(string: "\(NetworkManager.instance.BASE_URL)")!, config: [.log(true), .compress])
   
    static let instance = SocketService()
    
    override init() {
        super.init()
       
    }
    
    func establishConnection() {
        
        manager.defaultSocket.connect()

        
    }
    
    func stopConnection() {
        manager.defaultSocket.disconnect()
    }
    
   
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping (Bool) -> Void ) {

        if let user = NetworkManager.instance.loggedInUser {
            manager.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor )

            completion(true)
        }
        
    }
    
}
