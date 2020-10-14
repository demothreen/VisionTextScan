//
//  AppDelegate.swift
//  VisionTextScan
//
//  Created by demothreen on 14.10.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
		var window: UIWindow?

		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
				window = UIWindow(frame: UIScreen.main.bounds)
				window?.makeKeyAndVisible()
				window?.rootViewController = ViewController()
				return true
		}


}
