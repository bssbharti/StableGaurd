//
//  AppDelegate.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 24/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?
   var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        setNavigationBar()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func awsPoolSetup(){
        // setup logging
        AWSDDLog.sharedInstance.logLevel = .verbose
        AWSManager.shared.setupCognitoIdentityUserPool()
        // fetch the user pool client we initialized in above step
        let pool = AWSManager.shared.userPool
    }
    //MARK -sharedDelegate -
    class var sharedDelegate:AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    //MARK - setNavigationBar -
    func setNavigationBar()
    {
        let font : UIFont = OpenSans.Bold.font(size: 18) ?? UIFont.boldSystemFont(ofSize: 18)
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.yellow
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -220), for:.default)
        
        
    }
    func setupLogin(){
     let navigationController =   mainStoryboard.instantiateViewController(withIdentifier: StoryBoardIdentity.KLoginNavigationVC) as! UINavigationController
        self.window?.rootViewController = navigationController
        
    }
    func setupHome(){
        let navigationController =   mainStoryboard.instantiateViewController(withIdentifier: StoryBoardIdentity.kHomeNavigationVC) as! UINavigationController
        self.window?.rootViewController = navigationController
        
    }
    func setUpMain(isLogin:Bool){
        if isLogin {
            setupHome()
        }else{
            setupLogin()
        }
    }
}

