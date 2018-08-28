//
//  HomeVC.swift
//  Stablegaurd
//
//  Created by Jitendra Kumar on 24/08/18.
//  Copyright © 2018 Jitendra Kumar. All rights reserved.
//

import UIKit

let videoUrl = URL(string: "https://v.cdn.vine.co/r/videos/AA3C120C521177175800441692160_38f2cbd1ffb.1.5.13763579289575020226.mp4")!
class HomeVC: UIViewController {
    
    @IBOutlet weak var settingBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    fileprivate var records = [Any]()
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - onRefresh -
    @IBAction func onRefresh(_ sender: Any) {
        
    }
    //MARK: - onSupportCall -
    @IBAction func onSupportCall(_ sender: Any) {
        let busPhone = ""
        if let url = URL(string: "tel://\(busPhone)"), UIApplication.shared.canOpenURL(url) {
            
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentity.kSettingsMenuSegue {
            
            
            let controller  = segue.destination as! SettingsMenuVC
            if let popoverController = controller.popoverPresentationController {
                popoverController.barButtonItem = settingBtn
                popoverController.delegate = self
            }
            controller.onSelectMenuOption { (menuOption:SettingsMenuOptions) in
                
            }
            
        }else if segue.identifier == SegueIdentity.kAddNewCameraSegue{
            let controller  = segue.destination as! AddNewCameraVC
            controller.OnAddCameraAuthication { (isAuthcate) in
                
            }
        }
    }
}
extension HomeVC:UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        if Platform.isPhone {
            return .none
        }else{
            return .popover
        }
        
    }
}
extension HomeVC:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // updateVisibility(in: scrollView);
    }
    func updateVisibility(in scrollView: UIScrollView) {
        if (tableView == nil) { return }
        let relativeToScrollViewRect: CGRect =  tableView.convert(tableView.bounds, to: scrollView)//convert(bounds, to: scrollView)
        let visibleScrollViewRect = CGRect(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)
        guard let indexPaths = self.tableView.indexPathsForVisibleRows else{
            //Do something with an indexPaths array.
            return;
        }
        var visbleCell:VideoCell!
        for indexPath in indexPaths {
            let temp  = tableView.cellForRow(at: indexPath) as? VideoCell
            if let cell = temp {
                visbleCell = cell
            }
        }
        if moreThenHalfOf(relativeToScrollViewRect, visibleIn: visibleScrollViewRect) {
            // visible half - resume
            if (visbleCell != nil){
                visbleCell.isPlay = true
            }
            
        } else {
            // supposed to be paused
        }
        
    }
    func moreThenHalfOf(_ rect: CGRect, visibleIn visibleRect: CGRect) -> Bool {
        return visibleRect.contains(CGPoint(x: rect.midX, y: rect.midY))
        
    }
}

extension HomeVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  records.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if records.count > indexPath.row {
            let cell  = tableView.dequeueReusableCell(withIdentifier: TBCellIdentity.kVideoCell, for: indexPath) as! VideoCell
            cell.videoItemUrl = videoUrl
            return cell
        }
        else{
            let footerCell = tableView.dequeueReusableCell(withIdentifier: TBCellIdentity.kAddNewCameraFooterCell , for: indexPath) as! FooterCell
            
            return footerCell
        }
        
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < 9 {
            //let temp  = cell as! VideoCell
            // temp.isPlay = true
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row < 9 {
            let temp  = cell as! VideoCell
            if temp.isPlay {
                temp.isPlay = false
            }
        }
    }
    
}
