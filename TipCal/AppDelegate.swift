//
//  AppDelegate.swift
//  TipCal
//
//  Created by admin on 8/8/15.
//  Copyright (c) 2015 datdn1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication)
    {
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(NSDate(), forKey: "lastAccess")
        var viewCtrl = (self.window?.rootViewController as UINavigationController).viewControllers.first as ViewController
        var billValue = (viewCtrl.billTextField.text as NSString).doubleValue
        userDefault.setDouble(billValue, forKey: "billValue")
        
        var tipAmountValue = (viewCtrl.tipAmountLabel.text! as NSString).doubleValue
        userDefault.setDouble(tipAmountValue, forKey: "tipAmountValue")
        
        var amountValue = (viewCtrl.amountLabel.text! as NSString).doubleValue
        userDefault.setDouble(amountValue, forKey: "amountValue")
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
        var viewCtrl = (self.window?.rootViewController as UINavigationController).viewControllers.first as ViewController
        viewCtrl.updateView()
    }

    func applicationWillTerminate(application: UIApplication) {
        var userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setObject(true, forKey: "isLaunched")
    }


}

