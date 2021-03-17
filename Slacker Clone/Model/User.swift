//
//  User.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/15/21.
//

import UIKit

struct User: Codable {
    var userName: String
    var email:    String
    var password: String
    var avatar:   Data?
}
