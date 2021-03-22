//
//  SocketService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/22/21.
//

import Foundation
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    let manager = SocketManager(socketURL: URL(string: NetworkManager.instance.BASE_URL)!)
    
    let socket = SocketIOClient(manager: SocketService.instance.manager, nsp: "")
    
    
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
      socket.connect()
        print("Socket connected")
    }
    
    func closeConnection() {
        socket.disconnect()
        print("Socket disconnected")
    }
    
}
