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

    
    @IBOutlet weak var tableView: UITableView!

    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRefresh(_ sender: Any) {
    }
    
    @IBAction func onSupportCall(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentity.kSettingsMenuSegue {
            
            
//            let popOverController  = segue.destination as! SettingsMenuVC
//            popOverController.modalPresentationStyle = .popover
//            popOverController.popoverPresentationController!.delegate = self
//            popOverController.popoverPresentationController?.sourceView = countryCodeTF
//            popOverController.popoverPresentationController?.sourceRect = countryCodeTF.bounds
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
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: TBCellIdentity.kVideoCell, for: indexPath) as! VideoCell
        cell.videoItemUrl = videoUrl
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 300
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let temp  = cell as! VideoCell
        temp.isPlay = true
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let temp  = cell as! VideoCell
        temp.isPlay = false
    }
}
