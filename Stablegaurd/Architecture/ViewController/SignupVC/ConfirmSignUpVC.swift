//
//  ConfirmSignUpVC.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 27/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit

class ConfirmSignUpVC: UIViewController {

    @IBOutlet weak var emailTF: JKTextField!
    @IBOutlet weak var confirmationCodeTF: JKTextField!
    
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
    @IBAction func onConfirm(_ sender: Any)
    {
    }
    @IBAction func onResend(_ sender: Any)
    {
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
