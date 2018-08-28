//
//  Extensions.swift
//  Event Planner
//
//  Created by 360Itpro on 5/20/15.
//  Copyright (c) 2015 360 IT Professionals Ltd. All rights reserved.
//


import UIKit
import MobileCoreServices


//MARK:- EXTENSION FOR Data
extension Data {
    
    var intValue:     Int         { return withUnsafeBytes { $0.pointee }      }
    var int32Value:   Int32       { return withUnsafeBytes { $0.pointee }      }
    var int64Value:   Int64       { return withUnsafeBytes { $0.pointee }      }
    var floatValue:   Float       { return withUnsafeBytes { $0.pointee }      }
    var doubleValue:  Double      { return withUnsafeBytes { $0.pointee }      }
    var stringValue:  String?     { return String(data: self, encoding: .utf8) }
}
//MARK:- EXTENSION FOR Int
extension Int {
    var stringValue:  String     {  return NSNumber(value: self).stringValue  }
    var int8Value:    Int8       {  return NSNumber(value: self).int8Value    }
    var int16Value:   Int16      {  return NSNumber(value: self).int16Value   }
    var int32Value:   Int32      {  return NSNumber(value: self).int32Value   }
    var int64Value:   Int64      {  return NSNumber(value: self).int64Value   }
    var floatValue:   Float      {  return NSNumber(value: self).floatValue   }
    var doubleValue:  Double     {  return NSNumber(value: self).doubleValue  }
    var boolValue:    Bool       {  return NSNumber(value: self).boolValue    }
    var decimalValue: Decimal    {  return NSNumber(value: self).decimalValue }
    
}
//MARK:- EXTENSION FOR Float
extension Float {
    
    var stringValue:  String     {  return NSNumber(value: self).stringValue  }
    var intValue:     Int        {  return NSNumber(value: self).intValue     }
    var int8Value:    Int8       {  return NSNumber(value: self).int8Value    }
    var int16Value:   Int16      {  return NSNumber(value: self).int16Value   }
    var int32Value:   Int32      {  return NSNumber(value: self).int32Value   }
    var int64Value:   Int64      {  return NSNumber(value: self).int64Value   }
    var doubleValue:  Double     {  return NSNumber(value: self).doubleValue  }
    var boolValue:    Bool       {  return NSNumber(value: self).boolValue    }
    var decimalValue: Decimal    {  return NSNumber(value: self).decimalValue }
}
//MARK:- EXTENSION FOR Double
extension Double {
    
    var stringValue:  String     {  return NSNumber(value: self).stringValue  }
    var intValue:     Int        {  return NSNumber(value: self).intValue     }
    var int8Value:    Int8       {  return NSNumber(value: self).int8Value    }
    var int16Value:   Int16      {  return NSNumber(value: self).int16Value   }
    var int32Value:   Int32      {  return NSNumber(value: self).int32Value   }
    var int64Value:   Int64      {  return NSNumber(value: self).int64Value   }
    var floatValue:   Float      {  return NSNumber(value: self).floatValue   }
    var boolValue:    Bool       {  return NSNumber(value: self).boolValue    }
    var decimalValue: Decimal    {  return NSNumber(value: self).decimalValue }
    
}
//MARK:- EXTENSION FOR Bool
extension Bool {
    var stringValue:  String     {  return NSNumber(value: self).stringValue  }
    var intValue:     Int        {  return NSNumber(value: self).intValue     }
    
}

//MARK:- EXTENSION FOR NSAttributedString
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.width
    }
}
//MARK:- EXTENSION FOR String
extension String {
    
    
    var numberFormatter:NumberFormatter { return NumberFormatter()                               }
    var intValue:       Int?            { return numberFormatter.number(from: self)?.intValue    }
    var int8Value:      Int8?           { return numberFormatter.number(from: self)?.int8Value   }
    var int16Value:     Int16?          { return numberFormatter.number(from: self)?.int16Value  }
    var int32Value:     Int32?          { return numberFormatter.number(from: self)?.int32Value  }
    var int64Value:     Int64?          { return numberFormatter.number(from: self)?.int64Value  }
    var floatValue:     Float?          { return numberFormatter.number(from: self)?.floatValue  }
    var doubleValue:    Double?         { return numberFormatter.number(from: self)?.doubleValue }
    var boolValue:      Bool?           { return numberFormatter.number(from: self)?.boolValue   }
    var decimalValue:   Decimal?        { return numberFormatter.number(from: self)?.decimalValue}
    var binaryValue:    Data?           { return self.data(using: .utf8)                         }
    var length:         Int             { return self.count                                      }
    
    var pairs: [String] {
        var result: [String] = []
        let characters = Array(self)
        stride(from: 0, to: count, by: 2).forEach {
            result.append(String(characters[$0..<min($0+2, count)]))
        }
        return result
    }
    
    var isAlphanumericWithWhiteSpace: Bool {
        let regex = try! NSRegularExpression(pattern: "[^A-Z0-9a-z ]", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    
    var isAlphanumeric: Bool {
        
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9 ]", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
        
    }
    //MARK:- isValidPassword
    var isValidPassword: Bool
    {
        if (self.isEmpty)
        {
            return false
        }
        
        let passRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordTest=NSPredicate(format: "SELF MATCHES %@", passRegEx);
        return passwordTest.evaluate(with: self)
        
        
    }
    var removeWhiteSpace:String{
        return self.components(separatedBy: .whitespaces).joined(separator: "")
    }
    
    var isEmail: Bool {
        
        let regex = try? NSRegularExpression(pattern: "^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$", options: .caseInsensitive)
        
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    var checkSpecial: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9 ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
            
        }else{
            return true
        }
    }
    var checkAddress: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9._@#/()-+*., ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
            
        }else{
            return true
        }
    }
    var checkNumbers:Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return true
            
        }else{
            return false
        }
    }
    var onlyNumbers : Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^0-9].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var checkPhoneNumber:Bool{
        get{
            let phone_regex = "^\\d{3}-\\d{3}-\\d{4}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phone_regex)
            return phoneTest.evaluate(with: self)
        }
    }
    
    var onlyNumbersExpressionPlus: Bool {
        let regex = try! NSRegularExpression(pattern: ".*[^0-9+].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    var onlyAlphabet:  Bool{
        
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
        if regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil {
            return false
        }else{
            return true
        }
    }
    func insert(_ string:String,ind:Int) -> String {
        return  String(self.prefix(ind)) + string + String(self.suffix(self.count-ind))
    }
    
    
    var containsAlphabets: Bool {
        //Checks if all the characters inside the string are alphabets
        let set = CharacterSet.letters
        return self.utf16.contains( where: { return set.contains(UnicodeScalar($0)!)  } )
    }
    /// Returns a new string made from the `String` by replacing all characters not in the unreserved
    /// character set (As defined by RFC3986) with percent encoded characters.
    
    var stringByAddingPercentEncoding: String? {
        let allowedCharacters = NSCharacterSet.urlQueryAllowed
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        
    }
    /// Regular string.
    var regular: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Bold string.
    var bold: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Underlined string
    var underline: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    /// Strikethrough string.
    var strikethrough: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue as Int)])
    }
    
    /// Italic string.
    var italic: NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    
    func safelyLimitedTo(length n: Int)->String {
        let c = String(self)
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
    func substring(to : Int) -> String? {
        if (to >= length) {
            return nil
        }
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[..<toIndex])
        
    }
    
    func substring(from : Int) -> String? {
        if (from >= length) {
            return nil
        }
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
    
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return  String(self[Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))])
        
    }
    
    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }
    
    /// Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    
    //MARK: - subscript
    subscript(range: ClosedRange<Int>) -> String {
        let lowerIndex = index(startIndex, offsetBy: max(0,range.lowerBound), limitedBy: endIndex) ?? endIndex
        return  String(self[lowerIndex..<(index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) ?? endIndex)])
        
    }
    subscript(i: Int) -> String {
        guard i >= 0 && i < self.count else { return "" }
        return String(self[index(startIndex, offsetBy: i)])
    }
    subscript(r: Range<Int>) -> String? {
        get {
            let stringCount = self.count as Int
            if (stringCount < r.upperBound) || (stringCount < r.lowerBound) {
                return nil
            }
            
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound - r.lowerBound)
            return String(self[(startIndex ..< endIndex)])
        }
    }
}

//MARK:-EXTENTION FOR CGRECT USING FOR CUSTOME LOADER(TRANSITIONSUBMIT BUTTON)
extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    
    
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        set {
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    
    
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
}

//MARK:- EXTENSION FOR TIMER
extension Timer {
    class func schedule(delay: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        return timer
    }
    class func schedule(repeatInterval interval: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        return timer
    }
}






//MARK:- EXTENSION FOR TEXTFIELD
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
}
//MARK:- EXTENSION FOR UIIMAGE
extension UIImage {
    var uncompressedPNGData:        Data      { return UIImagePNGRepresentation(self)!        }
    var highestQualityJPEGNSData:   Data      { return UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData:      Data      { return UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData:    Data      { return UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData:       Data      { return UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:    Data      { return UIImageJPEGRepresentation(self, 0.0)!  }
    
    
    func resizeImage(to newSize:CGSize) -> UIImage?
    {
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage : UIImage? =  UIGraphicsGetImageFromCurrentImageContext()  //UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    func scaleImage(to newSize: CGSize) -> UIImage? {
        let cgImage :CGImage = self.cgImage!
        let widthRatio  = newSize.width  / CGFloat(cgImage.width)
        let heightRatio = newSize.height / CGFloat(cgImage.height)
        let width:CGFloat =  newSize.width//CGFloat(cgImage.width / 2)
        var height:CGFloat = CGFloat(newSize.width)
        if widthRatio < heightRatio {
            height =  CGFloat(cgImage.height) * CGFloat(widthRatio)
            
        }
        
        let bitsPerComponent = cgImage.bitsPerComponent
        let bytesPerRow = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace
        let bitmapInfo = cgImage.bitmapInfo
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue)
        context?.interpolationQuality = .high
        context?.draw(cgImage, in: CGRect(origin: .zero, size: CGSize(width:width, height: height)))
        let scaledImage =  UIImage(cgImage: (context?.makeImage()!)!)
        return scaledImage
        
    }
}
//MARK:- EXTENSION FOR DATE
extension Date {
    
    
    var shortTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var mediumTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .medium
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var longTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .long
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var fullTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .full
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    
    var shortDateTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.dateStyle = .short
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var mediumDateTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .medium
        formater.dateStyle = .medium
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var longDateTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .long
        formater.dateStyle = .long
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var fullDateTimeDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .full
        formater.dateStyle = .full
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var shortDateDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.dateStyle = .short
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var mediumDateDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.dateStyle = .medium
        // US English Locale (en_US)
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var longDateDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.dateStyle = .long
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    var fullDateDisplay:String{
        let formater = DateFormatter()
        formater.timeStyle = .short
        formater.dateStyle = .full
        formater.locale = Locale(identifier: "en_US")
        return formater.string(from: self)
    }
    
    var timeDisplay:String{
        get{
            let secondAngle = Int(Date().timeIntervalSince(self))
            let minute = 60
            let hour = 60*minute
            let day  = 24*hour
            let week = 7*day
            let month = 4*week
            let quatient:Int
            let unit:String
            if secondAngle<minute {
                quatient = secondAngle
                unit = "second"
            }else if secondAngle<hour {
                quatient = secondAngle/minute
                unit = "min"
            }else if secondAngle<day {
                quatient = secondAngle/hour
                unit = "hour"
            }else if secondAngle<week {
                quatient = secondAngle/day
                unit = "day"
            }else if secondAngle<month {
                quatient = secondAngle/week
                unit = "week"
            }else  {
                quatient = secondAngle/month
                unit = "month"
            }
            return "\(quatient) \(unit)\(quatient == 1 ? "" :"s") ago"
        }
    }
    
    
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == .orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    func isGreaterThanEqualDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        //Compare Values
        if self.compare(dateToCompare) == .orderedDescending {
            isGreater = true
        }else if self.compare(dateToCompare) == .orderedSame {
            isGreater = true
        }else if self.compare(dateToCompare) == .orderedAscending {
            isGreater = false
        }
        
        //Return Result
        return isGreater
    }
    func isEqualDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqual = false
        
        //Compare Values
        if self.compare(dateToCompare) == .orderedSame {
            isEqual = true
        }
        
        //Return Result
        return isEqual
    }
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == .orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    func isLessThanEqaulDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }else if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isLess = true
        }else if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isLess = false
        }
        
        //Return Result
        return isLess
    }
    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    // convert Date to string date
    func dateToString(formater:String = "yyyy-MM-dd HH:mm:ss") -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater //yyyy-MM-dd///this is you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone? //.current  //
        let dateStamp = dateFormatter.string(from: self)
        return dateStamp
    }
    func dateFormat(dateStyle:DateFormatter.Style = .medium,timeStyle:DateFormatter.Style = .short) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateStamp = dateFormatter.string(from: self)
        return dateStamp
    }
    func changeDateFormate(formater:String = "yyyy-MM-dd HH:mm:ss") -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater //yyyy-MM-dd///this is you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateStamp = dateFormatter.string(from: self)
        let newdate = dateFormatter.date(from: dateStamp)
        return newdate!
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
}
//MARK:- EXTENSION FOR DEVICES
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    
}
//MARK: - Double Extension -
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
//MARK: - DispatchQueue Extension -
extension DispatchQueue {
    
    static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }
    
    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
    func syncResult<T>(_ closure: () -> T) -> T {
        var result: T!
        sync { result = closure() }
        return result
    }
}
public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
    
}
public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]){
            uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}
//MARK: - Array Extension -
extension Array {
    
    @discardableResult
    mutating func append(_ newArray: Array) -> CountableRange<Int> {
        let range = count..<(count + newArray.count)
        self += newArray
        return range
    }
    
    @discardableResult
    mutating func insert(_ newArray: Array, at index: Int) -> CountableRange<Int> {
        let mIndex = Swift.max(0, index)
        let start = Swift.min(count, mIndex)
        let end = start + newArray.count
        
        let left = self[0..<start]
        let right = self[start..<count]
        self = left + newArray + right
        return start..<end
    }
    
    mutating func remove<T: AnyObject> (_ element: T) {
        let anotherSelf = self
        
        removeAll(keepingCapacity: true)
        
        anotherSelf.each { (index: Int, current: Element) in
            if (current as! T) !== element {
                self.append(current)
            }
        }
    }
    
    func each(_ exe: (Int, Element) -> ()) {
        for (index, item) in enumerated() {
            exe(index, item)
        }
    }
}

extension Array where Element: Equatable {
    
    public func filter(_ predicate: NSPredicate) -> [Element] {
        return self.filter({predicate.evaluate(with: $0)})
    }
    
    /// Remove Dublicates
    var unique: [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        return self.reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
    }
    
    /// Check if array contains an array of elements.
    ///
    /// - Parameter elements: array of elements to check.
    /// - Returns: true if array contains all given items.
    public func contains(_ elements: [Element]) -> Bool {
        guard !elements.isEmpty else { // elements array is empty
            return false
        }
        var found = true
        for element in elements {
            if !contains(element) {
                found = false
            }
        }
        return found
    }
    
    /// All indexes of specified item.
    ///
    /// - Parameter item: item to check.
    /// - Returns: an array with all indexes of the given item.
    public func indexes(of item: Element) -> [Int] {
        var indexes: [Int] = []
        for index in 0..<self.count {
            if self[index] == item {
                indexes.append(index)
            }
        }
        return indexes
    }
    
    /// Remove all instances of an item from array.
    ///
    /// - Parameter item: item to remove.
    public mutating func removeAll(_ item: Element) {
        self = self.filter { $0 != item }
    }
    
    /// Creates an array of elements split into groups the length of size.
    /// If array can’t be split evenly, the final chunk will be the remaining elements.
    ///
    /// - parameter array: to chunk
    /// - parameter size: size of each chunk
    /// - returns: array elements chunked
    public func chunk(size: Int = 1) -> [[Element]] {
        var result = [[Element]]()
        var chunk = -1
        for (index, elem) in self.enumerated() {
            if index % size == 0 {
                result.append([Element]())
                chunk += 1
            }
            result[chunk].append(elem)
        }
        return result
    }
}

public extension Array {
    
    /// Random item from array.
    public var randomItem: Element? {
        if self.isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /// Shuffled version of array.
    public var shuffled: [Element] {
        var arr = self
        for _ in 0..<10 {
            arr.sort { (_,_) in arc4random() < arc4random() }
        }
        return arr
    }
    
    /// Shuffle array.
    public mutating func shuffle() {
        // https://gist.github.com/ijoshsmith/5e3c7d8c2099a3fe8dc3
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
    
    /// Element at the given index if it exists.
    ///
    /// - Parameter index: index of element.
    /// - Returns: optional element (if exists).
    public func item(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
}
//MARK: - NSUserDefaults Extension -
extension UserDefaults{
    class func jkDefault(setIntegerValue integer: Int , forKey key : String){
        UserDefaults.standard.set(integer, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func jkDefault(setObject object: Any , forKey key : String){
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func jkDefault(setValue object: Any , forKey key : String){
        UserDefaults.standard.setValue(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func jkDefault(setBool boolObject:Bool  , forKey key : String){
        UserDefaults.standard.set(boolObject, forKey : key)
        UserDefaults.standard.synchronize()
    }
    class func jkDefault(integerForKey  key: String) -> Int{
        let integerValue : Int = UserDefaults.standard.integer(forKey: key) as Int
        UserDefaults.standard.synchronize()
        return integerValue
    }
    class func jkDefault(objectForKey key: String) -> Any {
        let object  = UserDefaults.standard.object(forKey: key)
        if (object != nil) {
            UserDefaults.standard.synchronize()
            return object!
        }else{
            UserDefaults.standard.synchronize()
            return ""
        }
        
    }
    class func jkDefault(valueForKey  key: String) -> Any {
        let value  = UserDefaults.standard.value(forKey: key)
        if (value != nil) {
            UserDefaults.standard.synchronize()
            return value!
        }else{
            return ""
        }
        
    }
    class func jkDefault(boolForKey  key : String) -> Bool {
        let booleanValue : Bool = UserDefaults.standard.bool(forKey: key) as Bool
        UserDefaults.standard.synchronize()
        return booleanValue
    }
    
    class func jkDefault(removeObjectForKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    //Save no-premitive data
    class func jkDefault(setArchivedDataObject object: Any! , forKey key : String) {
        if (object != nil) {
            let data : NSData? = NSKeyedArchiver.archivedData(withRootObject: object) as NSData?
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
        
    }
    class func jkDefault(getUnArchiveObjectforKey key: String) -> Any {
        //var objectValue : Any?
        if  let storedData  = UserDefaults.standard.object(forKey: key) as? Data{
            
            let objectValue   =  NSKeyedUnarchiver.unarchiveObject(with: storedData)
            if (objectValue != nil)  {
                UserDefaults.standard.synchronize()
                return objectValue!
                
            }else{
                UserDefaults.standard.synchronize()
                return ""
                
            }
        }else{
            //objectValue = ""
            return ""
        }
    }
    
}

//MARK: - UIViewController Extension -
extension UIViewController{
    
    //MARK: - modalPresentation -
    func modalPresentation(){
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
    
    //MARK: - modalFromSheet -
    func modalFromSheet(){
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .formSheet
    }
    
    
    
    
 //MARK: - zoomBounceAnimation -
    func zoomBounceAnimation(containtView popUp:UIView){
        popUp.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        
        UIView.animate(withDuration: 0.3/1.5, animations: {
            popUp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (finished) in
            UIView.animate(withDuration: 0.3/2, animations: {
                popUp.transform = CGAffineTransform(scaleX:  0.9, y:  0.9)
            }) { (finished) in
                UIView.animate(withDuration: 0.3/2, animations: {
                    popUp.transform = .identity
                })
                
            }
        }
        
        
    }
    //MARK: - fadeAnimationController -
    func fadeAnimationController(duration:TimeInterval = 0.5,completion: ((Bool) -> Swift.Void)? = nil ){
        self.view.alpha = 0
        UIView.transition(with: self.view, duration: duration, options: .transitionCrossDissolve, animations: {
            
            self.view.alpha = 1.0
            if (completion != nil) {
                completion!(true)
            }
        }) { (finished:Bool) in
            
        }
    }
    //MARK: - showLogoutAlert -
    func showLogoutAlert(title:String = kAppTitle,message:String = "Are you sure you want to Log Out?"){
        
        let alertModel = AlertControllerModel(contentViewController: nil, title: title, message: message, titleFont: nil, messageFont: nil, titleColor: nil, messageColor: nil, tintColor: JKColor.Blue)
        let cancel = AlertActionModel(image: nil, title:"NO", color: JKColor.DarkYellow, style: .cancel)
        let destructive = AlertActionModel(image: nil, title:"YES", color: JKColor.Red, style: .destructive)
        _ = UIAlertController.showAlert(from: self, controlModel: alertModel, actions: [cancel,destructive]) { (alert:UIAlertController, action:UIAlertAction, buttonIndex:Int) in
            
            switch buttonIndex {
            case 1:
                
               // AppDelegate.sharedDelegate.logoutUser()
                
                break
                
            default:
                break
            }
        }
    }
    //MARK:- showAlert-
    func showAlertAction(title:String = kAppTitle,message:String?,cancelTitle:String = "Cancel",otherTitle:String = "OK",onCompletion:@escaping (_ didSelectIndex:Int)->Void){
        let alertModel = AlertControllerModel(contentViewController: nil, title: title, message: message, titleFont: nil, messageFont: nil, titleColor: nil, messageColor: nil, tintColor: JKColor.navigationBarColor)
        
        let cancel = AlertActionModel(image: nil, title:cancelTitle, color: JKColor.navigationBarColor, style: .cancel)
        let other = AlertActionModel(image: nil, title:otherTitle, color: JKColor.DarkYellow, style: .default)
        
        
        _ = UIAlertController.showAlert(from: self, controlModel: alertModel, actions: [cancel,other]) { (alert:UIAlertController, action:UIAlertAction, index:Int) in
            onCompletion(index)
        }
        // alertController.zoomBounceAnimation(containtView: alertController.view)
    }
    
    //MARK:- showAlert-
    func showAlert(title:String = kAppTitle,message:String?,completion:((_ didSelectIndex:Int)->Swift.Void)? = nil){
        
        let alertModel = AlertControllerModel(contentViewController: nil, title: title, message: message, titleFont: nil, messageFont: nil, titleColor: nil, messageColor: nil, tintColor: JKColor.navigationBarColor)
        let cancel = AlertActionModel(image: nil, title:"Ok", color: .black, style: .cancel)
        _ = UIAlertController.showAlert(from: self, controlModel: alertModel, actions: cancel) { (alert:UIAlertController, action:UIAlertAction, index:Int) in
            if (completion != nil) {
                completion!(index)
            }
        }
  
    }
    
    
    
    
}

//MARK: - UISearchBar Extension

extension UISearchBar{
    func setPlaceHolderColor(placeColor:UIColor = JKColor.Grey,textColor:UIColor = UIColor.darkGray,canceltitleColor:UIColor = JKColor.Blue) ->UITextField? {
        
        let searchTextField: UITextField? = self.value(forKey: "searchField") as? UITextField
        if (searchTextField?.responds(to: #selector(getter: UITextField.attributedPlaceholder)))! {
            
            let attributeDict = [NSAttributedStringKey.foregroundColor: placeColor]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeDict)
            searchTextField!.textColor = textColor
            searchTextField?.clearButtonMode = .never
            
        }
        for subView in self.subviews
        {
            if subView.isKind(of:UIButton.self)
            {
                let searchbtn : UIButton = subView as! UIButton
                searchbtn .setTitleColor(canceltitleColor, for:.normal)
            }
        }
        return searchTextField
    }
    
}



import Kingfisher

//MARK: - UIImageView Extension

extension UIImageView{
    
    func loadImage(filePath:String, progressBlock: DownloadProgressBlock? = nil,onCompletion: ((_ image: Image?, _ error: NSError?)->Swift.Void)? = nil ){
        
        
        
        self.kf.setImage(with: (filePath as! Resource), placeholder: #imageLiteral(resourceName: "suit1"), options: [.transition(ImageTransition.fade(1))], progressBlock: progressBlock) { (image, error, cacheType, imageURL) in
            if (onCompletion != nil) {
                if (error != nil){
                    
                    onCompletion!(nil,error)
                }else{
                    onCompletion!(image,nil)
                }
            }
            
        }
    }
    
}
//MARK: - UIButton Extension
extension UIButton{
    
    //MARK: - loadImage
    func loadImage(filePath:String,for state: UIControlState, progressBlock: DownloadProgressBlock? = nil,onCompletion: ((_ image: Image?, _ error: NSError?)->Swift.Void)? = nil ){
        
        self.kf.setImage(with: URL(string: filePath), for: state, placeholder: #imageLiteral(resourceName: "suit1"), options: [.transition(ImageTransition.fade(1))], progressBlock: progressBlock) { (image, error, cacheType, imageURL) in
            if (onCompletion != nil) {
                if (error != nil){
                    
                    onCompletion!(nil,error)
                }else{
                    onCompletion!(image,nil)
                }
            }
            
        }
        
        
        
    }
    //MARK: - loadBackgroundImage
    func loadBackgroundImage(filePath:String,for state: UIControlState, progressBlock: DownloadProgressBlock? = nil,onCompletion: ((_ image: Image?, _ error: NSError?)->Swift.Void)? = nil){
        
        
        self.kf.setBackgroundImage(with:URL(string: filePath), for: state, placeholder: #imageLiteral(resourceName: "suit1"), options: [.transition(ImageTransition.fade(1))], progressBlock: progressBlock) { (image, error, cacheType, imageURL) in
            if (onCompletion != nil) {
                if (error != nil){
                    
                    onCompletion!(nil,error)
                }else{
                    onCompletion!(image,nil)
                }
            }
            
        }
    }
}
//MARK: - UILabel Extension
extension UILabel {
    
    func heightToFit(_ string:String,width:CGFloat) -> CGFloat{
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.byWordWrapping
        let rect = string.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return rect.height
        
    }
    
    func resizeHeightToFit() {
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.byWordWrapping
        let rect = text!.boundingRect(with: CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        self.frame.size.height = rect.height
    }
}
//MARK: - CALayer Extension
extension CALayer {
    
    enum AniamtionStyle{
        
        case Push
        case Reveal
        case MoveIn
        case Fade
        var aniamtionStyle: String {
            switch self {
            case .Push:
                return kCATransitionPush
            case .Reveal:
                return kCATransitionReveal
            case .MoveIn:
                return kCATransitionMoveIn
            case .Fade:
                return kCATransitionFade
                
            }
        }
    }
    enum AniamtionSubStyle{
        
        case Left
        case Right
        case Top
        case Bottom
        case None
        var aniamtionSubStyle: String {
            switch self {
            case .Left:
                return kCATransitionFromLeft
            case .Right:
                return kCATransitionFromRight
            case .Top:
                return kCATransitionFromTop
            case .Bottom:
                return kCATransitionFromBottom
            case .None:
                return ""
            }
            
        }
        
    }
    fileprivate var transition :CATransition {
        get{
            let transition = CATransition()
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            return transition
        }
    }
    fileprivate func removedAllAnimations(){
        self.removeAllAnimations()
    }
    func addAnimation(style:AniamtionStyle = .Fade,subStyle:AniamtionSubStyle = .None, duration:CFTimeInterval = 0.5){
        transition.duration = duration
        transition.type = style.aniamtionStyle
        if subStyle != .None {
            transition.subtype = subStyle.aniamtionSubStyle
        }
        
        self.add(transition, forKey: kCATransition)
        
    }
    
    
}
//MARK: - UIView Extension
extension UIView{
    
    func sizeAnchor(to view:UIView){
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    func anchor(top:NSLayoutYAxisAnchor?,leading:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,trailing:NSLayoutXAxisAnchor?,padding:UIEdgeInsets = .zero,size:CGSize = .zero){
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
