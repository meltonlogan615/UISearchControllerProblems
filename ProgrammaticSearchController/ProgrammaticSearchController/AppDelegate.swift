//
//  AppDelegate.swift
//  ProgrammaticSearchController
//
//  Created by Logan Melton on 3/7/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let mainView = ViewController()
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.backgroundColor = .systemBackground
    window?.rootViewController = UINavigationController(rootViewController: mainView)
    
    return true
  }

}

