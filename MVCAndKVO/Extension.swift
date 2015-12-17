//
//  Extension.swift
//  MVCAndKVO
//
//  Created by Alix.Kang on 12/17/15.
//  Copyright © 2015 Guanglu. All rights reserved.
//

import UIKit

// MARK: UIColor
extension UIColor {
    public convenience init (hexValue : Int, alpha : CGFloat = 1)  {
        let r = CGFloat((hexValue>>16) & 0xFF) / 255.0
        let g = CGFloat((hexValue>>8) & 0xFF) / 255.0
        let b = CGFloat(hexValue & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    public class func color(hexValue : Int) -> UIColor {
        return UIColor(hexValue: hexValue, alpha: 1)
    }
    
    public var toImage : UIImage {
       return toImage(width: 1, height: 1)
    }
    
    public func toImage(size : CGSize) -> UIImage {
        return toImage(width: size.width, height: size.height)
    }
    
    public func toImage(width imageWidth : CGFloat, height imageHeight: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, imageWidth, imageHeight)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
// MARK: UIView
extension UIView {
    
    var top : CGFloat {
        set {
            frame = CGRectMake(frame.origin.x, newValue, frame.width, frame.height)
        }
        get {
            return frame.origin.y
        }
    }
    
    var left : CGFloat {
        set {
            frame = CGRectMake(newValue, frame.origin.y, frame.width, frame.height)
        }
        get {
            return frame.origin.x
        }
    }
    
    var bottom : CGFloat {
        set {
            frame = CGRectMake(frame.origin.x, newValue - frame.height, frame.width, frame.height)
        }
        get {
            return frame.origin.y + frame.height
        }
    }
    
    var width : CGFloat {
        set {
            frame = CGRectMake(frame.origin.x, frame.origin.y, newValue, frame.height)
        }
        get {
            return frame.width
        }
    }
    
    
    var height : CGFloat {
        set {
            frame = CGRectMake(frame.origin.x, frame.origin.y, frame.width, newValue)
        }
        get {
            return frame.height
        }
    }
    
    var right : CGFloat {
        set {
            frame = CGRectMake(newValue - frame.width, frame.origin.y, frame.width, frame.height)
        }
        get {
            return frame.origin.x + frame.width
        }
    }
    
    var centerX : CGFloat {
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
        get {
            return center.x
        }
    }
    
    var centerY : CGFloat{
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
        get {
            return center.y
        }
    }
    
    var toImage : UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, 0)
        if let ctx = UIGraphicsGetCurrentContext() {
            layer.renderInContext(ctx)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
        return nil
    }
    
}
// MARK: UIDevice
extension UIDevice {
    static var modelName : String { // e.g "iPhone7, 2"
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](count: size, repeatedValue: 0)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String.fromCString(machine)!
    }
    
    static var networkState : (flag:Bool, description:String) {
        if let foregroundView = UIApplication.sharedApplication().valueForKeyPath("statusBar")!.valueForKeyPath("foregroundView") {
            guard foregroundView is UIView else {
                return (false, "Disable")
            }
            
            for subview in (foregroundView as! UIView).subviews {
                if "\(subview.dynamicType)".containsString("UIStatusBarDataNetworkItemView") {
                    let netType = subview.valueForKeyPath("dataNetworkType")
                    guard netType is Int else {
                        return (false, "Disable")
                    }
                    
                    switch netType as! Int {
                    case 1: return (true, "2G")
                    case 2: return (true, "3G")
                    case 3: return (true, "4G")
                    case 5: return (true, "Wifi")
                    default:return (false, "Disable")
                    }
                }
            }
        }
        
        return (false, "Disable")
    }
}
// MARK: - UIScreen
extension UIScreen {
    
    static var width : CGFloat {
        return UIScreen.mainScreen().bounds.size.width
    }
    
    static var height : CGFloat {
        return UIScreen.mainScreen().bounds.size.height
    }
}
// MARK: - UIApplication
extension UIApplication {
    static var appVersion : String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static var buildNumber : String {
        return NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
    }
}