//
//  NetworkManager.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/15/21.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static let instance = NetworkManager()
    
    let BASE_URL = "http://localhost:3005"
    
    let defaults = UserDefaults.standard
    
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
    
    func urlWithEndpoint(_ type: URLEndpoint) -> String {
        return "\(BASE_URL)\(type)"
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let lowerCasedEmail = email.lowercased()
        
        let header: HTTPHeaders? = [
            "Content-Type" : "applicatioin/json"
        ]
        
        let body: [String : Any] = [
            "email": lowerCasedEmail,
            "password": password
        ]
        
        AF.request(urlWithEndpoint(.reigisterUser), method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.error as Any)
            }
        }
        
        
    }
}

