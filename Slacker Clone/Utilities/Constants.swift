//
//  Constants.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/16/21.
//

import Foundation
import Alamofire

let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let HEADER: HTTPHeaders = [
    "Content-Type" : "application/json"
]

enum URLEndpoint: String {
    case reigisterUser = "/v1/account/register"
    case loginUser     = "/v1/account/login"
    case addUser       = "/v1/user/add"
    case byUserEmail   = "/v1//user/byEmail/"
}
