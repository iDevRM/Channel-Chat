//
//  NetworkManager.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/15/21.
//

import Foundation


struct NetworkManager {
    let BASE_URL = URL(string: "http://localhost:3005")
    
    
    func networkRequest(to query: URLQueries) {
        let url = URL(string: "\(BASE_URL)\(query)")
        
        
        let request = URLRequest(url: url!)
        request
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription)
                return
            }
            
            if let safeData = data, let safeResponse = response {
                
            }
        }
        
    }
    
}

enum URLQueries: String {
    case reigisterUser = "/v1/account/register"
    case loginUser     = "/v1/account/login"
    case addUser       = "/v1/user/add"
}
