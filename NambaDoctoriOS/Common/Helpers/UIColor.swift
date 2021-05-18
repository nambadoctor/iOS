//
//  UIColor.swift
//  CircleAppiOS
//
//  Created by Surya Manivannan on 16/07/20.
//  Copyright © 2020 SuryaManivannan. All rights reserved.
//

import Foundation
import UIKit

class CustomColors {
    static var SkyBlue:String = "SkyBlue"
}

extension UIColor {
    static let LightBlue = UIColor().colorFromHex("#D8E9FF")
    static let MediumBlue = UIColor().colorFromHex("#6CACFF")
    static let DarkBlue = UIColor().colorFromHex("#158BF1")
    static let LightGrey = UIColor().colorFromHex("#F8F8F8")
    static let MediumGrey = UIColor().colorFromHex("#BDBDBD")
    static let Red = UIColor().colorFromHex("#FF6161")
    static let Teal = UIColor().colorFromHex("#36D1DC")
    static let Green = UIColor().colorFromHex("#10C977")
    
    func colorFromHex (_ hex:String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb : UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha: 1.0)
    }

}
