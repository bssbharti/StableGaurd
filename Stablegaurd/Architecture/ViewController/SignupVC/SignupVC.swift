//
//  SignupVC.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 27/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
class SignupVC: UIViewController {

    var pool: AWSCognitoIdentityUserPool?{
        return AWSManager.shared.userPool
    }
    @IBOutlet weak var emailTF: JKTextField!
    @IBOutlet weak var passwordTF: JKTextField!
    @IBOutlet weak var confirmPasswordTF: JKTextField!

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onSignUp(_ sender: Any) {
         guard let email = emailTF.text else { return  }
         guard let password = passwordTF.text else { return  }
         guard let confPassword = confirmPasswordTF.text else { return  }
        
        AWSManager.shared.awsSignup(email: email, password: password, confirmPassword: confPassword, OnSuccess: { (isSuccess, response) in
            
        }, OnFailure: {(error) in
            
            })
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentity.kConfirmSignUpSegue {
            
        }
    }
   

}

