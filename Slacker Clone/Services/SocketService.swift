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
            guard let channelName        = dataArray[0] as? String,
                  let channelDescription = dataArray[1] as? String,
                  let channelId          = dataArray[2] as? String else { return }
           
            
            let newChannel = Channel(name: channelName, desciption: channelDescription, id: channelId)
            
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func getNewMessage(_ completionHandler: @escaping (_ newMessage: Message) -> Void ) {
        socket.on("messageCreated") { (dataArray, sockerAck) in
            guard let body           = dataArray[0] as? String,
                  let userId         = dataArray[1] as? String,
                  let channelId      = dataArray[2] as? String,
                  let userName       = dataArray[3] as? String,
                  let avatarName     = dataArray[4] as? String,
                  let avatarColor    = dataArray[5] as? String,
                  let messageId      = dataArray[6] as? String,
                  let timeStamp      = dataArray[7] as? String else { return }
            
            let newMessage = Message(messageId: messageId, body: body, time: timeStamp, channelId: channelId, userName: userName, userId: userId, userAvatarName: avatarName, userAvatarColor: avatarColor)
            
            completionHandler(newMessage)
            
        }
    }
    
    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String : String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, socketACK) in
            guard let typingUsers = dataArray[0] as? [String : String] else { return }
            completionHandler(typingUsers)
        }
    }
    
    
}
