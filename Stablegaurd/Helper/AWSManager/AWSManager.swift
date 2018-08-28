//
//  AWSManager.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 24/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider
typealias AWSManagerSuccessBlock = (_ isSuccess:Bool,_ response:Any?)->Void
typealias AWSManagerFailureBlock = (_ err:Error)->Void

class AWSManager:NSObject{
    
    
    
    struct AWSUserPoolKeys {
        
        static let kCognitoIdentityUserPoolResion : AWSRegionType = .USEast2
        static let KCognitoIdentityClientId = "7ltb130v7sg2a9c2nqvdi3qkep"
        static let kCognitoIdentityClientSecret = "6a28afkp83oe8sk0iknlmt0codnnnm3jp26jia59i0162ofpvei"
        static let KCognitoIdentityPoolId = "us-east-2_6nB8OENMa"
        static let KCognitoPoolConfigurationKey = "UserPool"
    }
    
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
   lazy var serviceConfiguration:AWSServiceConfiguration = {
        return AWSServiceConfiguration(region:AWSUserPoolKeys.kCognitoIdentityUserPoolResion, credentialsProvider: nil)
    }()
   lazy var poolConfiguration:AWSCognitoIdentityUserPoolConfiguration = {
      
          return  AWSCognitoIdentityUserPoolConfiguration(clientId: AWSUserPoolKeys.KCognitoIdentityClientId, clientSecret: AWSUserPoolKeys.kCognitoIdentityClientSecret, poolId: AWSUserPoolKeys.KCognitoIdentityPoolId)
       
    }()
    var userPool: AWSCognitoIdentityUserPool? {
           return AWSCognitoIdentityUserPool(forKey: AWSUserPoolKeys.KCognitoPoolConfigurationKey)
        
    }
    func setupCognitoIdentityUserPool(){
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: AWSUserPoolKeys.KCognitoPoolConfigurationKey)
    }
    //get the last logged in user
    var currentUser:AWSCognitoIdentityUser?{
        return userPool?.currentUser()
    }
    //get a user without a username
    var user:AWSCognitoIdentityUser?{
        return userPool?.getUser()
    }
    //get a user with a specific username
    var username:String?{
        return user?.username
    }
    override init() {
        super.init()
        //userPool.delegate = self
    }
    
    class var shared:AWSManager{
        
        struct  Singlton{
            
            static let instance = AWSManager()
            
        }
        
        return Singlton.instance
    }
    
    func awsLogin(email:String,password:String , OnSuccess:@escaping AWSManagerSuccessBlock, OnFailure:@escaping AWSManagerFailureBlock){
        if email.isEmpty {
            alertMessage = FieldValidation.kEmailEmpty
        }else if !email.isEmail{
            alertMessage = FieldValidation.kValidEmail
        }else if password.isEmpty{
            alertMessage = FieldValidation.kPasswordEmpty
        }else{
           // guard let user = self.user else {return}
             let authDetails =  AWSCognitoIdentityPasswordAuthenticationDetails(username: email, password: password)
           self.passwordAuthenticationCompletion?.set(result: authDetails)
            user?.getSession(email, password: password, validationData: nil).continueWith(block: { (task) -> Any? in
                
                if let err = task.error as NSError?{
                    OnFailure(err)
                }else if let result = task.result {
                    
                }
                return nil
            })
        }
       
    }
    func awsSignup(email:String,password:String,confirmPassword:String, OnSuccess:@escaping AWSManagerSuccessBlock, OnFailure:@escaping AWSManagerFailureBlock){
        if email.isEmpty {
              alertMessage = FieldValidation.kEmailEmpty
        }else if !email.isEmail{
            alertMessage = FieldValidation.kValidEmail
        }else if password.isEmpty{
             alertMessage = FieldValidation.kPasswordEmpty
        }else if confirmPassword.isEmpty{
            alertMessage = FieldValidation.kConfirmPassEmpty
        }else if password.length>7{
            alertMessage = FieldValidation.kPassMinLimit
        }else if password.isValidPassword{
            alertMessage = FieldValidation.kValidPass
        }else if password != confirmPassword{
             alertMessage = FieldValidation.kPassMissMatch
        }else{
           
           ServerManager.shared.showHud()
            self.userPool?.signUp(email, password: password, userAttributes: nil, validationData: nil).continueWith {  (task) -> Any? in
                ServerManager.shared.hideHud()
                if let err = task.error as NSError?{
                    OnFailure(err)
                }else if let result = task.result {
                    if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {
                        let sentTo = result.codeDeliveryDetails?.destination
                        OnSuccess(true,sentTo )
                    } else {
                        OnSuccess(false,nil)
                    }
                }
                
                
                   return nil
            }
        }
    }
    func awsUserVerification(){
        
    }
    func getUserDetail(){
        
    }
    
}





