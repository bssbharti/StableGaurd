//
//  Constant.swift
//  UtilityDemoSwift3
//
//  Created by Jitendra Kumar on 30/12/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//

import Foundation
import UIKit






var appIconName:String  {
    
    get{
        var infoDic = Bundle.main.infoDictionary!
        if infoDic["CFBundleIcons"] != nil {
            infoDic = infoDic["CFBundleIcons"] as! Dictionary
            infoDic = infoDic["CFBundlePrimaryIcon"] as! Dictionary
            return(infoDic["CFBundleIconFiles"]! as AnyObject).object(at: 0) as! String
            
            
        } else {
           
            print("Oops... no app icon found")
             return ""
        }
    }
 
}

var appIcon:UIImage? {
    get{
        
        if (!appIconName.isEmpty){
           let icon = UIImage(named:appIconName)!
             return icon
        }else{
            return nil
        }
       
    }
}

let kNotAvaialable = "Not Available"
let mainStoryboard:UIStoryboard = {
    return UIStoryboard(name: "Main", bundle: nil)
}()
let homeStoryboard:UIStoryboard = {
    return UIStoryboard(name: "Home", bundle: nil)
}()
var accessToken:String{
    get{
        guard let accessToken = UserDefaults.jkDefault(objectForKey: kAuthTokenKey) as? String else { return "" }
        return accessToken
    }
}
var rootController:UIViewController?{
    return AppDelegate.sharedDelegate.window?.rootViewController
}
var alertMessage: String? {
    didSet{
        guard let controller  =  rootController else {  return }
        controller.showAlert(message: alertMessage)
       
    }
}



let kAppImage:UIImage = appIcon ?? #imageLiteral(resourceName: "suit1")
let kAppTitle             =   (AppInfo.kAppTitle.isEmpty == true) ? "Vendata":AppInfo.kAppTitle
let kOops                   = "Oops!!☹"
let kConnectionError        = "No Internet Connection!☹"
let KSuccess                = "Success!!😀"
let kDeviceToken            = "device_token"
let kDeviceID               = "UUIDString"
let kUserDataKey            = "UserData"
let kAuthTokenKey           = "AuthToken"
let kFCMSubscriptionKey     = "FCMSubscription"


//Web Service Constant String-

let kClientUrl =  ""

let kClientAPIurl = ""
let kTestAPIurl = ""

let kBaseUrl = kClientUrl+kTestAPIurl

