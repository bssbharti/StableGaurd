//
//  JKButton.swift
// JKMaterialKit
//
//  Created by Jitendra Kumar on 27/12/16.
//  Copyright © 2016 Jitendra. All rights reserved
//

import UIKit

@IBDesignable
open class JKButton : UIButton
{
    
    @IBInspectable public var imageColor: UIColor = .clear {
        didSet {
            
            if imageColor != .clear {
                
                if  let image = self.image(for: UIControlState()) {
                    let tmImage  = image.withRenderingMode(.alwaysTemplate)
                    self.setImage(tmImage, for: UIControlState())
                    self.tintColor = imageColor
                    
                }else if let image = self.backgroundImage(for: UIControlState()) {
                    let tmImage  = image.withRenderingMode(.alwaysTemplate)
                    self.setBackgroundImage(tmImage, for: UIControlState())
                    self.tintColor = imageColor
                    }
            }
           
        }
    }
    
   
    @IBInspectable public var isShadow: Bool = false
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var shadowRadius : CGFloat = 3
        {
        didSet
        {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            //mkLayer.setMaskLayerCornerRadius(cornerRadius)
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
            //mkLayer.setMaskLayerCornerRadius(cornerRadius)
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
            didSet
            {
              layer.masksToBounds = masksToBounds
        }
    }
   
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
        }
    }
  


    // MARK - initilization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
 
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    // MARK - setup methods
    private func setupLayer() {
        adjustsImageWhenHighlighted = false
        
    }

   
    override open func layoutSubviews() {
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
        
    }

}
extension UIButton {
    // MARK: - UIButton+Aligment
    
    func alignContentVerticallyByCenter(offset:CGFloat = 10) {
        let buttonSize = frame.size
        
        if let titleLabel = titleLabel,
            let imageView = imageView {
            
            if let buttonTitle = titleLabel.text,
                let image = imageView.image {
                let titleString:NSString = NSString(string: buttonTitle)
                let titleSize = titleString.size(withAttributes: [
                    NSAttributedStringKey.font : titleLabel.font
                    ])
                let buttonImageSize = image.size
                
                let topImageOffset = (buttonSize.height - (titleSize.height + buttonImageSize.height + offset)) / 2
                let leftImageOffset = (buttonSize.width - buttonImageSize.width) / 2
                imageEdgeInsets = UIEdgeInsetsMake(topImageOffset,
                                                   leftImageOffset,
                                                   0,0)
                
                let titleTopOffset = topImageOffset + offset + buttonImageSize.height
                let leftTitleOffset = (buttonSize.width - titleSize.width) / 2 - image.size.width
                
                titleEdgeInsets = UIEdgeInsetsMake(titleTopOffset,
                                                   leftTitleOffset,
                                                   0,0)
            }
        }
    }
}
