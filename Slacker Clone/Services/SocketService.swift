//
//  SocketService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/22/21.
//

import Foundation
import SocketIO




    
class SocketService: NSObject {
    
    var manager = SocketManager(socketURL: URL(string: "\(NetworkManager.instance.BASE_URL)")!, config: [.log(true), .compress])
    
    static let instance = SocketService()
    
    override init() {
        super.init()
        let socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Socket Connected")
        }
        socket.connect()
    }
    
   
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping (Bool) -> Void ) {

        let user = NetworkManager.instance.loggedInUser!
        let socket = manager.defaultSocket
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor )

        completion(true)
    }
    
}
