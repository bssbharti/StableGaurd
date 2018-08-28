//
//  SettingsMenuVC.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 27/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit

class SettingsMenuVC: UITableViewController {
    typealias SettingMenuBlcok = (_ option:SettingsMenuOptions)->Void
    fileprivate var handler :SettingMenuBlcok?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let block = handler ,let option = SettingsMenuOptions(rawValue: indexPath.row){
            block(option)
        }
    }
    func onSelectMenuOption(completion:@escaping SettingMenuBlcok){
        handler = completion
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
