//
//  UIAlertController.swift
//  B2BApp
//
//  Created by Jitendra Kumar on 30/01/18.
//  Copyright © 2018 Mobilyte. All rights reserved.
//

//MARK:- EXTENTION FOR ALERT VIEW CONTROLLER
import UIKit

typealias UIAlertActionHandler = (_ controller:UIAlertController, _ action:UIAlertAction, _ buttonIndex:Int)->Void
enum UIAlertActionIndex:Int {
    case CancelButtonIndex = 0
    case DestructiveButtonIndex = 1
    case FirstOtherButtonIndex = 2
    case otherFieldIndex = 4
}

struct AlertFields {
    var placeholder:String = ""
    var isSecureTextEntry:Bool = false
    var borderStyle:UITextBorderStyle = .none
    init(placeholder:String,isSecure:Bool = false,borderStyle:UITextBorderStyle = .none) {
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        self.borderStyle = borderStyle
    }
    
}


import AudioToolbox
struct AlertControllerModel {
    var contentViewController:UIViewController? = nil
    var title:String?
    var message:String?
    var titleFont:UIFont? = nil
    var messageFont:UIFont? = nil
    var titleColor:UIColor? = nil
    var messageColor:UIColor? = nil
    var tintColor:UIColor = UIColor.black
    
    
}
struct AlertActionModel {
    var image: UIImage? = nil
    var title: String = "Cancel"
    var color: UIColor? = nil
    var style: UIAlertActionStyle = .cancel
}
extension UIAlertController{
    
    
    fileprivate var cancelButtonIndex        :Int        { return UIAlertActionIndex.CancelButtonIndex.rawValue       }
    fileprivate var firstOtherButtonIndex    :Int        { return UIAlertActionIndex.FirstOtherButtonIndex.rawValue   }
    fileprivate var destructiveButtonIndex   :Int        { return UIAlertActionIndex.DestructiveButtonIndex.rawValue  }
    fileprivate var addTextFieldIndex        :Int        { return UIAlertActionIndex.otherFieldIndex.rawValue         }
    
    //MARK: - convenience init
    convenience init(model:AlertControllerModel, preferredStyle:UIAlertControllerStyle = .alert, source: UIView? = nil) {
        self.init(title: model.title, message: model.message, preferredStyle: preferredStyle, source: source, tintColor: model.tintColor)
        
        if let controller = model.contentViewController {
            self.set(vc: controller)
        }
        if let title  = model.title, let font = model.titleFont , let color  = model.titleColor{
            self.set(title: title, font: font, color: color)
        }
        if let message  = model.message, let font = model.messageFont , let color  = model.messageColor{
            self.set(message: message, font: font, color: color)
        }
    }
    convenience init(title:String?  = nil, message:String?  = nil , preferredStyle:UIAlertControllerStyle = .alert, source: UIView? = nil, tintColor:UIColor = UIColor.black){
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        
        // TODO: for iPad or other views
        #if os(iOS)
            if preferredStyle == .actionSheet, let source = source {
                
                if let barButtonItem = source as? UIBarButtonItem {
                    
                    if let popoverController = self.popoverPresentationController {
                        popoverController.barButtonItem = barButtonItem
                        popoverController.sourceRect = source.bounds
                    }
                    
                }else{
                    if let popoverController = self.popoverPresentationController {
                        popoverController.sourceView = source
                        popoverController.sourceRect = source.bounds
                    }
                    
                }
            }
        #endif
        self.view.tintColor = tintColor
    }
    
    //MARK: - presentAlert
    fileprivate func presentAlert(from viewController:UIViewController = AppDelegate.sharedDelegate.window!.rootViewController!, completion: (() -> Swift.Void)? = nil){
        DispatchQueue.main.async {
            viewController.present(self, animated: true, completion: completion)
        }
    }
    //MARK: - otherAlertAction
    fileprivate func otherAlertAction(others:[AlertActionModel],handler:@escaping UIAlertActionHandler){
        for (index,obj) in others.enumerated() {
            addAction(image: obj.image, title: obj.title, color: obj.color, style: .default, handler: { (action:UIAlertAction) in
                handler(self,action,self.firstOtherButtonIndex+index)
            })
            
        }
        
    }
    //MARK: - cancelAlertAction
    fileprivate func cancelAlertAction(cancel:AlertActionModel,handler:@escaping UIAlertActionHandler){
        
        addAction(image: cancel.image, title: cancel.title, color: cancel.color, style: .cancel, handler: { (action:UIAlertAction) in
            handler(self,action,self.cancelButtonIndex)
        })
        
    }
    //MARK: - destructiveAlertAction
    fileprivate  func destructiveAlertAction(destructive:AlertActionModel,handler:@escaping UIAlertActionHandler){
        addAction(image: destructive.image, title: destructive.title, color: destructive.color, style: .destructive, handler: { (action:UIAlertAction) in
            handler(self,action,self.destructiveButtonIndex)
        })
        
    }
    //MARK: - OtherTextField
    fileprivate  func addOtherTextField(placeholders: [AlertFields]?){
        if (placeholders != nil) {
            for (index,element) in placeholders!.enumerated() {
                self.addTextField { textField in
                    textField.tag = self.addTextFieldIndex+index
                    textField.placeholder = NSLocalizedString(element.placeholder, comment: "")
                    textField.borderStyle = element.borderStyle
                    textField.isSecureTextEntry = element.isSecureTextEntry
                }
            }
        }
        
        
    }
    
    
    
    //MARK: - Add an action to Alert
    
    /*
     *   - Parameters:
     *   - title: action title
     *   - style: action style (default is UIAlertActionStyle.default)
     *   - isEnabled: isEnabled status for action (default is true)
     *   - handler: optional action handler to be called when button is tapped (default is nil)
     */
    fileprivate func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
    
    /* Set alert's title, font and color
     *
     * - Parameters:
     *   - title: alert title
     *  - font: alert title font
     *   - color: alert title color
     */
    fileprivate  func set(title: String?, font: UIFont, color: UIColor) {
        if title != nil {
            self.title = title
        }
        setTitle(font: font, color: color)
    }
    
    fileprivate func setTitle(font: UIFont, color: UIColor) {
        guard let title = self.title else { return }
        let attributes: [NSAttributedStringKey: Any] = [.font: font, .foregroundColor: color]
        let attributedTitle = NSMutableAttributedString(string: title, attributes: attributes)
        setValue(attributedTitle, forKey: "attributedTitle")
        print("new title = \(attributedTitle)")
    }
    
    /* Set alert's message, font and color
     *
     *   - Parameters:
     *   - message: alert message
     *   - font: alert message font
     *   - color: alert message color
     */
    fileprivate func set(message: String?, font: UIFont, color: UIColor) {
        if message != nil {
            self.message = message
        }
        setMessage(font: font, color: color)
    }
    
    fileprivate func setMessage(font: UIFont, color: UIColor) {
        guard let message = self.message else { return }
        let attributes: [NSAttributedStringKey: Any] = [.font: font, .foregroundColor: color]
        let attributedMessage = NSMutableAttributedString(string: message, attributes: attributes)
        setValue(attributedMessage, forKey: "attributedMessage")
    }
    
    /* Set alert's content viewController
     *
     *   - Parameters:
     *   - vc: ViewController
     *   - height: height of content viewController
     */
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    fileprivate func addAlertAction(actions:Any,otherTextFields placeholders:[AlertFields]? = nil,alertActionHandler:  @escaping UIAlertActionHandler) -> UIAlertController{
        
        if let list  = actions as? [AlertActionModel] {
            var others:[AlertActionModel] = [AlertActionModel]()
            for obj in list{
                if obj.style == .destructive{
                    self.destructiveAlertAction(destructive: obj, handler: alertActionHandler)
                }else if obj.style == .cancel{
                    self.cancelAlertAction(cancel: obj, handler: alertActionHandler)
                }else{
                    others.append(obj)
                }
            }
            
            if others.count>0{
                self.otherAlertAction(others: others, handler: alertActionHandler)
            }
        }else if  let obj = actions as? AlertActionModel{
            if obj.style == .destructive{
                self.destructiveAlertAction(destructive: obj, handler: alertActionHandler)
            }else if obj.style == .default{
                self.otherAlertAction(others: [obj], handler: alertActionHandler)
            }else{
                self.cancelAlertAction(cancel: obj, handler: alertActionHandler)
            }
        }
        
        if (placeholders != nil) {
            self.addOtherTextField(placeholders: placeholders)
        }
        
        return self
    }
    
    //MARK: - Class Functions
    
    class func setupAlertControl(obj:AlertControllerModel, preferredStyle:UIAlertControllerStyle = .alert, source: UIView? = nil) -> UIAlertController{
        let controller = UIAlertController(model: obj, preferredStyle: preferredStyle, source: source)
        return controller
    }
    class func showAlert(from viewController:UIViewController ,controlModel:AlertControllerModel, actions:Any,otherTextFields placeholders:[AlertFields]? = nil, source: UIView? = nil,isBounce:Bool = true, alertActionHandler:@escaping UIAlertActionHandler)-> UIAlertController{
        
        let alert = self.setupAlertControl(obj: controlModel, preferredStyle: .alert, source: source).addAlertAction(actions: actions, otherTextFields: placeholders, alertActionHandler: alertActionHandler)
        if isBounce{
            alert.zoomBounceAnimation(containtView: alert.view)
        }
        alert.presentAlert(from: viewController) {}
        return alert
        
    }
    class func showActionSheet(from viewController:UIViewController!,controlModel:AlertControllerModel, actions:Any, source: UIView? = nil,alertActionHandler:@escaping UIAlertActionHandler) -> UIAlertController{
        
        let alert = self.setupAlertControl(obj: controlModel, preferredStyle: .actionSheet, source: source).addAlertAction(actions: actions,alertActionHandler: alertActionHandler)
        alert.presentAlert(from: viewController) {}
        return alert
    }
    
}
