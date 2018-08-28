//
//  AppEnums.swift
//  B2BApp
//
//  Created by Jitendra Kumar on 15/12/17.
//  Copyright © 2017 Mobilyte. All rights reserved.
//

import Foundation

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

enum SettingsMenuOptions:Int {
    case AddNewUser = 0
    case BlockForPrivacy  
    var description:String{
        switch self {
        case .AddNewUser:
            return "add new user"
        default:
            return "Block for Privacy"
        }
    }
}
