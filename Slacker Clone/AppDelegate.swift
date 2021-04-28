//
//  AppDelegate.swift
//  Slacker Clone
//
//  Created by Ricardo Martinez on 3/10/21.
//

import UIKit
import SocketIO


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SocketService.instance.establishConnection()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        SocketService.instance.stopConnection()
    }
    
}



