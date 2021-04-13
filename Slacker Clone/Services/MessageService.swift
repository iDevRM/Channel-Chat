//
//  MessageService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/7/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    
    func findAllChannels(completion: @escaping (Bool) -> Void ) {
        
        AF.request(NetworkManager.instance.urlWithEndpoint(type: .getChannels), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.error == nil {
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let description = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let newChannel = Channel(name: name, desciption: description, id: id)
                            
                            self.channels.append(newChannel)
                        }
                        completion(true)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }

            } else {
                completion(false)
                print(response.error as Any)
            }
        }
        
    }
    
    func getAllMessages(for channel: Channel, completion: @escaping (Bool,[Message]) -> Void ) {
        
        var arrayOfMessages: [Message] = []
        
        let url = URL(string: "\(NetworkManager.instance.urlWithEndpoint(type: .getAllMessages))\(channel.id!)")!
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.error == nil {
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSON(data: data).array {
                        for message in json {
                            let message = Message(channelId: message["channelId"].stringValue, userName: message["userName"].stringValue, body: message["messageBody"].stringValue)
                            arrayOfMessages.append(message)
                        }
                    }
                    
                    completion(true,arrayOfMessages)
                    
                } catch {
                    
                    print(error.localizedDescription)
                    
                }
                
            } else {
                
                completion(false,arrayOfMessages)
                print(response.error as Any)
                
            }
            
        }
        
    }
    
}
