//
//  JKImageView.swift
// JKMaterialKit
//
//  Created by Jitendra Kumar on 27/12/16.
//  Copyright © 2016 Jitendra. All rights reserved
//

import UIKit

@IBDesignable
public class JKImageView: UIImageView
{
   

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

    


    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    override public init(image: UIImage?) {
        super.init(image: image)
   
    }

    override public init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
       
    }

    

}
extension JKImageView{
    
}
