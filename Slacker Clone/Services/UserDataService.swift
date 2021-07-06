//
//  UserDataService.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 4/27/21.
//

import Foundation
import UIKit

class UserDataService {
    
    static let instance = UserDataService()
    
    fileprivate var _id          = ""
    fileprivate var _avatarColor = ""
    fileprivate var _avatarName  = ""
    fileprivate var _email       = ""
    fileprivate var _name        = ""
    
    var id: String {
        get {
            return _id
        }
        set {
            _id = newValue
        }
    }
    
    var avatarColor: String {
        get {
            return _avatarColor
        }
        set {
            _avatarColor = newValue
        }
    }
    
    var avatarName: String {
        get {
            return _avatarName
        }
        set {
            _avatarName = newValue
        }
    }
    
    var email: String {
        get {
            return _email
        }
        set {
            _email = newValue
        }
    }
     
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    func returnUIColor(components: String) -> UIColor {
        
        let scanner = Scanner(string: components)
        
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma   = CharacterSet(charactersIn: ",")
        let bracket = CharacterSet(charactersIn: "]")
        scanner.charactersToBeSkipped = skipped
        
        var red, green, blue, alpha : String?
        
        red   = scanner.scanUpToCharacters(from: comma)
        green = scanner.scanUpToCharacters(from: comma)
        blue  = scanner.scanUpToCharacters(from: comma)
        alpha = scanner.scanUpToCharacters(from: bracket)
        
        let defaultColor = UIColor(red: 0.69, green: 0.85, blue: 0.99, alpha: 1)
        
        guard let redUnwrapped   = red,
              let greenUnwrapped = green,
              let blueUnwrapped  = blue,
              let alphaUnwrapped = alpha else { return defaultColor }
        
        let redFloat   = CGFloat(Double(redUnwrapped)!)
        let greenFloat = CGFloat(Double(greenUnwrapped)!)
        let blueFloat  = CGFloat(Double(blueUnwrapped)!)
        let alphaFloat = CGFloat(Double(alphaUnwrapped)!)
        
        let newUIColor = UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
        
        return newUIColor
        
    }

    
}
