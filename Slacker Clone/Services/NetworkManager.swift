//
//  NetworkManager.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/15/21.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkManager {
    
    static let instance = NetworkManager()
    
    let BASE_URL = "http://localhost:3005"
    
    let defaults = UserDefaults.standard
    
    var loggedInUser: User? 
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.setValue(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.setValue(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.setValue(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    func urlWithEndpoint(type: URLEndpoint) -> String {
        return "\(BASE_URL)\(type.rawValue)"
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        let lowerCasedEmail = email.lowercased()
        
        let body: [String : Any] = [
            "email": lowerCasedEmail,
            "password": password
        ]
        
        AF.request(urlWithEndpoint(type: .reigisterUser), method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void ) {
        
        let lowerCasedEmail = email.lowercased()
        
        let body: [String : Any] = [
            "email": lowerCasedEmail,
            "password": password
        ]
        
        AF.request(urlWithEndpoint(type: .loginUser), method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString(completionHandler: { (response) in
            
            if response.description.contains("invalid") {
                completion(false)
            } else {
                if let data = response.data {
                    do {
                        let json = try JSON(data: data)
                        self.userEmail = json["email"].stringValue
                        self.authToken = json["token"].stringValue
                        self.isLoggedIn = true
                    } catch {
                        print(error)
                    }
                }
                completion(true)
            }
        })
    }
    
    func createUser(name: String, email: String, avatarColor: String, avatarName: String, completion: @escaping (Bool) -> Void) {
        
        let lowecasedEmail = email.lowercased()
        
        let header: HTTPHeaders = [
            BEARER_HEADER[0],
            HEADER[0]
        ]
        
        let body: [String: Any] = [
            "name": name,
            "email": lowecasedEmail,
            "avatarColor": avatarColor,
            "avatarName": avatarName
        ]
        
        AF.request(urlWithEndpoint(type: .addUser), method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.error == nil {
                completion(true)
            } else {
                completion(false)
                print(response.error!.localizedDescription)
            }
        }
    }
    
    func findUserByEmail(email: String, completion: @escaping (Bool) -> Void) {
        let url = "\(urlWithEndpoint(type: .byUserEmail))\(email.lowercased())"
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.error == nil {
                guard let data = response.data else { return }
                
                do {
                    let json = try JSON(data: data)
                    let user = User(_id: json["_id"].stringValue, name: json["name"].stringValue, email: json["email"].stringValue, avatarName: json["avatarName"].stringValue, avatarColor: json["avatarColor"].stringValue)
                    self.loggedInUser = user
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                }
                
            } else {
                completion(false)
                print(response.error!.localizedDescription)
            }
            
        }
    }
    
    
}



