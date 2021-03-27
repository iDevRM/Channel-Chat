//
//  SocketService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/22/21.
//

import Foundation
import SocketIO

let manager = SocketManager(socketURL: URL(string:"\(NetworkManager.instance.BASE_URL)")!, config: [.log(true), .compress])
var socket = manager.defaultSocket


    
class SocketService {
    
    static let instance = SocketService()
    
   
    func establishConnection() {
        
        socket.connect()

            
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping (Bool) -> Void ) {
        
        let user = NetworkManager.instance.loggedInUser!
        
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor )
        
        completion(true)
    }
    
}
