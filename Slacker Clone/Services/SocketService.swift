//
//  SocketService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/22/21.
//

import Foundation
import SocketIO


let manager = SocketManager(socketURL: URL(string: "\(NetworkManager.instance.BASE_URL)")!, config: [.log(true), .compress])
let socket = manager.defaultSocket


class SocketService: NSObject {
    
   
    static let instance = SocketService()
    
    override init() {
        super.init()
        
    }
    
    func establishConnection() {
        
        
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }

        socket.connect()
        
    }
    
    func stopConnection() {
        
        socket.disconnect()
         
    }
    
   
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping (Bool) -> Void ) {

        if let user = NetworkManager.instance.loggedInUser {
            socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor )

            completion(true)
        }
        
    }
    
}
