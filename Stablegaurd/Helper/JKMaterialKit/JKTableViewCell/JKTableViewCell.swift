//
//  JKTableViewCell.swift
// JKMaterialKit
//
//  Created by Jitendra Kumar on 27/12/16.
//  Copyright © 2016 Jitendra. All rights reserved
//

import UIKit

@IBDesignable
public class JKTableViewCell : UITableViewCell {
    

    /// Whether to display the shadow, defaults to false.
    @IBInspectable public var isShadow: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// The color of the drop-shadow, defaults to black.
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            
            if isShadow == true {
                layer.shadowColor = shadowColor.cgColor
            }
            self.setNeedsDisplay()
        }
    }
  
    /// The opacity of the drop-shadow, defaults to 0.5.
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            if isShadow == true {
                layer.shadowOpacity = shadowOpacity
            }
            
            self.setNeedsDisplay()
        }
    }
    /// The x,y offset of the drop-shadow from being cast straight down.
    @IBInspectable public var shadowOffset: CGSize = CGSize(width:0,height:3) {
        didSet {
            if isShadow == true {
                layer.shadowOffset = shadowOffset
            }
            self.setNeedsDisplay()
        }
    }
    /// The blur radius of the drop-shadow, defaults to 3.
    @IBInspectable public var shadowRadius : CGFloat = 3.0
        {
        didSet
        {   if isShadow == true {
            layer.shadowRadius = shadowRadius
            }
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            
            self.setNeedsDisplay()
        }
    }
    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
        didSet
        {
            if isShadow == true {
                layer.masksToBounds = false
            }
            else{
                layer.masksToBounds = masksToBounds
            }
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
            self.setNeedsDisplay()
        }
    }
    //accessoryView image
    @IBInspectable public var rightAccessory: UIImage?
        {
        didSet {
            if (rightAccessory != nil)
            {
                self.accessoryView = UIImageView(image: rightAccessory)
            }
        }
    }
    
     override public func layoutSubviews() {
        super.layoutSubviews()
        if isShadow == true
        {
            
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            layer.masksToBounds = masksToBounds
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowPath = shadowPath.cgPath
        }
        else{
            // Disable the shadow.
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
        self.setNeedsDisplay()
    }
   
    
    

    
  
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }

    private func setupLayer() {
        selectionStyle = .none
       
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
     
    }
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        super.touchesBegan(touches, with: event)
        
    }
}
class JKTableView: UITableView {
    
    
    /// Whether to display the shadow, defaults to false.
    @IBInspectable public var isShadow: Bool = false{
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    /// The color of the drop-shadow, defaults to black.
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            
            if isShadow == true {
                layer.shadowColor = shadowColor.cgColor
            }
            self.setNeedsDisplay()
        }
    }
    
    /// The opacity of the drop-shadow, defaults to 0.5.
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            if isShadow == true {
                layer.shadowOpacity = shadowOpacity
            }
            
            self.setNeedsDisplay()
        }
    }
    /// The x,y offset of the drop-shadow from being cast straight down.
    @IBInspectable public var shadowOffset: CGSize = CGSize(width:0,height:3) {
        didSet {
            if isShadow == true {
                layer.shadowOffset = shadowOffset
            }
            self.setNeedsDisplay()
        }
    }
    /// The blur radius of the drop-shadow, defaults to 3.
    @IBInspectable public var shadowRadius : CGFloat = 3.0
        {
        didSet
        {   if isShadow == true {
            layer.shadowRadius = shadowRadius
            }
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            
            self.setNeedsDisplay()
        }
    }
    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
            self.setNeedsDisplay()
            
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
        didSet
        {
            if isShadow == true {
                layer.masksToBounds = false
            }
            else{
                layer.masksToBounds = masksToBounds
            }
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
            self.setNeedsDisplay()
        }
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if isShadow == true
        {
            
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            layer.masksToBounds = masksToBounds
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowPath = shadowPath.cgPath
        }
        else{
            // Disable the shadow.
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
        self.setNeedsDisplay()
    }
    
    
    
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}
