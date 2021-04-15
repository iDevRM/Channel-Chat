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
            print("Socket Connected")
        }

        socket.connect()
        
    }
    
    func stopConnection() {
        
        socket.disconnect()
         
    }
    
   
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping (Bool) -> Void) {

        if let user = NetworkManager.instance.loggedInUser {
            socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor )

            completion(true)
        }
        
    }
    
    func addChannel(name: String, description: String, completion: @escaping (Bool) -> Void) {
        
        socket.emit("newChannel", name, description)
        
        completion(true)
        
    }
    
    func getChannel(completion: @escaping (Bool) -> Void) {
        socket.on("channelCreated") { (dataArray, socketAck) in
            guard let name = dataArray[0] as? String,
                  let desc = dataArray[1] as? String,
                  let id = dataArray[2] as? String else { return }
           
            
            let newChannel = Channel(name: name, desciption: desc, id: id)
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    
}
