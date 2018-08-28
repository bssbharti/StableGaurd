//
//  AppUtility.swift
//  B2BApp
//
//  Created by Jitendra Kumar on 06/12/17.
//  Copyright © 2017 Mobilyte. All rights reserved.
//

import UIKit


struct EmojiFontIcon {
    static let rightArraow = "→"
    static let leftArrow = "←"
    static  let bulletIcon = "•"
    static  let radioselect = "◉"
    static  let rediounSelect = "◎"
    static let downTrangle = "▾"
    static let rightTrangle = "‣"
    static let leftTrangle = "◀︎"
    static let sadEmoji = "☹"
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    
    static let IS_IPHONE_4_OR_LESS          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5_OR_SE            = UIDevice.current.userInterfaceIdiom  == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_OR_7             = UIDevice.current.userInterfaceIdiom  == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_OR_7P           = UIDevice.current.userInterfaceIdiom  == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD                      = UIDevice.current.userInterfaceIdiom  == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO                  = UIDevice.current.userInterfaceIdiom  == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
    static var isPhone:Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? true :false
    }
}

struct DeviceModel
{
    static let  kiPodTouch5    = "iPod Touch 5"
    static let  kiPodTouch6    = "iPod Touch 6"
    static let  kiPhone4       = "iPhone 4"
    static let  kiPhone4s      = "iPhone 4s"
    static let  kiPhone5       = "iPhone 5"
    static let  kiPhone5c      = "iPhone 5c"
    static let  kiPhone5s      = "iPhone 5s"
    static let  kiPhone6       = "iPhone 6"
    static let  kiPhone6Plus   = "iPhone 6 Plus"
    static let  kiPhone6s      = "iPhone 6s"
    static let  kiPhone6sPlus  = "iPhone 6s Plus"
    static let  kiPhone7       = "iPhone 7"
    static let  kiPhone7Plus   = "iPhone 7 Plus"
    static let  kiPhoneSE      = "iPhone SE"
    static let  kiPad2         = "iPad 2"
    static let  kiPad3         = "iPad 3"
    static let  kiPad4         = "iPad 4"
    static let  kiPadAir       = "iPad Air"
    static let  kiPadAir2      = "iPad Air 2"
    static let  kiPadMini      = "iPad Mini"
    static let  kiPadMini2     = "iPad Mini 2"
    static let  kiPadMini3     = "iPad Mini 3"
    static let  kiPadMini4     = "iPad Mini 4"
    static let  kiPadPro9Inch  = "iPad Pro (9.7-inch)"
    static let  kiPadPro12Inch = "iPad Pro (12.9-inch)"
}
struct AppInfo {
    static let bundleDisplayName =  Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    static let bundleName = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
    static let kAppTitle = bundleDisplayName ?? bundleName ?? ""
    static let kAppVersionString: String = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    static let kBuildNumber: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
}




struct SegueIdentity {
  
    static let kSettingsMenuSegue             = "SettingsMenuSegue"
    static let kLoginSegue                    = "LoginSegue"
    static let kSignUpSegue                   = "SignUpSegue"
    static let kConfirmSignUpSegue            = "ConfirmSignUpSegue"
    static let kForgotPasswordSegue           = "ForgotPasswordSegue"
    static let KConfirmForgotPasswordSegue    = "ConfirmForgotPasswordSegue"

    
}

struct StoryBoardIdentity {
    
    static let KLoginVC                 = "LoginVC"
    static let KLoginNavigationVC       = "LoginNavigationVC"
    static let kForgotVC                = "ForgotVC"
    static let kUserProfileNavigationVC = "UserProfileNavigationVC"
    static let kHomeVC                  = "HomeVC"
    static let kHomeNavigationVC        = "HomeNavigationVC"
}


struct TBCellIdentity {
    
    
    
    static let kVideoCell    = "VideoCell"
    static let kLoadMoreCell = "LoadMoreCell"
    static let kCustomerCell = "CustomerCell"
    static let kCountryPickerCell = "CountryPickerCell"
}

struct CVCellIdentity {
    static let kProductHeaderCell    = "ProductHeaderCell"
    static let kLoadMoreGridCell     = "LoadMoreGridCell"
    static let kProductGridCell      = "ProductGridCell"
    static let kSubProductGridCell   = "SubProductGridCell"
    static let kMediaCell            = "MediaCell"
    static let kMediaGirdCell        = "MediaGirdCell"
 
   
    
}

struct FieldValidation {
    
    static let kUserNameEmpty      = "Please enter user name."
    static let kFirstNameEmpty     = "Please enter first name."
    static let kLastNameEmpty      = "Please enter last name."
    static let kAddressEmpty       = "Please enter address."
    static let kCityEmpty          = "Please enter city."
    static let kStateEmpty         = "Please enter state/province."
    static let kZipCodeEmpty       = "Please enter zip/postal code."
    static let kCountryEmpty       = "Please enter country."
    static let kPhoneEmpty         = "Please enter phone number."
    static let kPhoneLimit         = "Your phone number should be 10 digit."
    static let kPhoneFormateValid  = "Please enter valid phone number."
    
    
    
    static let kEmailEmpty           = "Please enter email id."
    static let kValidEmail           = "Please enter the valid email."
    static let kcountryCode          = "Please select country Code."
    static let kPasswordEmpty        = "Please enter password."
    static let kAlreadyUsedPassword  = "You have already used this password, please try another password."
    static let kCurrentPasswordEmpty = "Please enter current password."
    static let kPassMinLimit         = "Your password should be minimum of 8 character."
    static let kPassMaxLimit         = "Your password must be less then 20 character."
    static let kValidPass           =  """
                                           • Password must contain  numbers .
                                           • Password must contain uppercase letters
                                           • Password must have at least one @#$ sumbol
                                           • Lenght must be greater than 7 characters
                                       """
    static let kConfirmPassEmpty     = "Please enter confirm password."
    static let kPassMissMatch        = "Password doesn't match."
    static let kAgreeTC              = "Please agree terms & conditions."
    static let kAuthSessionExpire    = "Your login session got expired, Please try login again."
    static let kAuthorizationDenied  = "Authorization has been denied for this request."
    static let kOTPCodeEmpty         = "Please enter verification code."
    static let kValidOTPCode         = "Verification code should contain only numbers."
 
    
    
  
}



