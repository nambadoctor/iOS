//
//  Helpers.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 13/01/21.
//

import Foundation
import SwiftUI

class Helpers {
    static func returnFlag(country:String) -> String {
        let base = 127397
        var usv = String.UnicodeScalarView()
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
    
    static func utcToLocal(dateStr: String) -> String {
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: dateStr)// create   date from string
                                             
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date!)
        
        return timeStamp
    }
    
    static func convertB64ToUIImage (b64Data:String) -> UIImage? {
        print("encoded string data: \(b64Data)")
        let newImageData = Data(base64Encoded: b64Data)
        
        if let newImageData = newImageData {
            print("CONVERTING TO IMAGE \(String(describing: UIImage(data: newImageData)))")
           return UIImage(data: newImageData)
        } else {
            print("FAILED TO CONVERT TO IMAGE")
            return nil
        }
    }

    static func getTimeFromTimeStamp(timeStamp : Int64) -> String {

         let formatter = DateFormatter()

         formatter.timeZone = TimeZone.current

         formatter.dateFormat = "dd MMM, h:mm a"
         formatter.amSymbol = "AM"
         formatter.pmSymbol = "PM"

         let dateString = formatter.string(from: Date(milliseconds: timeStamp))
        
        
         let day = DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: Date(milliseconds: timeStamp)) - 1]
         return "\(day), \(dateString)"
     }
    
    static func getDatePickerStringFromDate (date:Date) -> [String] {
        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "dd"

        let dateString = formatter.string(from: date)
        
        let day = "\(DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1])"
        
        return [day[0], dateString]
    }
    
    static func compareDate (date1:Date, date2:Date) -> Bool {
        let order = Calendar.current.compare(date1, to: date2, toGranularity: .day)

        if order == .orderedSame {
            return true
        } else {
            return false
        }
    }
    
    static func compareDate (timestamp:Int64, date2:Date) -> Bool {
        let date1 = Date(milliseconds: timestamp)
        
        let order = Calendar.current.compare(date1, to: date2, toGranularity: .day)

        if order == .orderedSame {
            return true
        } else {
            return false
        }
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
