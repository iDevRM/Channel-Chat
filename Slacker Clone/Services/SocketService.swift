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
//        socket.on("newMessage") {data, ack in
//            print("socket connected")
//        }

//        socket.on("newMessage") {data, ack in
//            guard let cur = data[0] as? Double else { return }
//
//            socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
//                if data.first as? String ?? "passed" == SocketAckStatus.noAck {
//                    // Handle ack timeout
//                }
//
//                socket.emit("update", ["amount": cur + 2.50])
//            }
//
//            ack.with("Got your currentAmount", "dude")
//        }

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