//
//  JKLabel.swift
// JKMaterialKit
//
//  Created by Jitendra Kumar on 27/12/16.
//  Copyright © 2016 Jitendra. All rights reserved
//

import UIKit

public class JKLabel: UILabel {


  
    
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
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
    


    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
           
        }
    }
  
    override public var bounds: CGRect {
        didSet {
          
        }
    }
   

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
     
    }

   

   
    //addGlowingEffect-
    func addGlowingEffect()  {
        let labelTransparency :CGFloat = 0.5
        let labelWidth:CGFloat = self.frame.size.width
        
        let glowSize :CGFloat = 40 / labelWidth
        
        let startingLocations :NSArray = [NSNumber.init(value:0.0), NSNumber.init(value:((Float)(glowSize / 2))),NSNumber.init(value:((Float)(glowSize)/1))]
        
        let endingLocations = [(1.0 - glowSize), (1.0 - (glowSize / 2)), 1.0] as NSArray
        
        let animation :CABasicAnimation = CABasicAnimation(keyPath: "locations")
        let glowMask:CAGradientLayer = CAGradientLayer.init()
        glowMask.frame = self.bounds
        
        let gradient = UIColor.init(white: 0.5, alpha: labelTransparency)
        glowMask.colors =  [gradient.cgColor,UIColor.white.cgColor,gradient.cgColor]
        glowMask.locations = startingLocations as? [NSNumber]
        glowMask.startPoint =  CGPoint(x: 0 - (glowSize * 2), y: 1)
        glowMask.endPoint = CGPoint(x: 1 + glowSize, y: 1)
        self.layer.mask = glowMask
        
        animation.fromValue = startingLocations
        animation.toValue = endingLocations
        animation.repeatCount = Float.infinity
        animation.duration = 1.5
        animation.isRemovedOnCompletion = false
        glowMask.add(animation, forKey: "gradientAnimation")
    }
}
