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
    
    static func showImagePickerAlert (_ completion: @escaping ((_ sourceType:UIImagePickerController.SourceType) -> ())) -> Alert {
        let alert = Alert(title: Text("Choose Image"),
                          message: Text("How would you like to select your image?"),
                          primaryButton: .default(Text("Camera")) {
                            completion(.camera)},
                          secondaryButton: Alert.Button.default(Text("Gallery"), action: {
                            completion(.photoLibrary)
                          }))
        return alert
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
    
    static func getDateFromTimeStamp (timeStamp : Int64) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timeStamp))
    }
    
    static func getSimpleTimeSpanForAppointment (timeStamp1 : Int64, timeStamp2: Int64) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let dateString1 = formatter.string(from: Date(milliseconds: timeStamp1))
        let dateString2 = formatter.string(from: Date(milliseconds: timeStamp2))
        
        return "\(dateString1) - \(dateString2)"
    }
    
    static func getSimpleTimeForAppointment (timeStamp1 : Int64) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.timeZone = .current
        
        let dateString1 = formatter.string(from: Date(milliseconds: timeStamp1))
        
        return "\(dateString1)"
    }
    
    static func getDatePickerStringFromDate (date:Date) -> [String] {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "dd"
        
        let dateString = formatter.string(from: date)
        
        let day = "\(DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1])"
        
        return [day[0], dateString]
    }
    
    static func load3LetterDayName(timeStamp:Int64) -> String{
        let date = Date(milliseconds: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EE"
        return dateFormatter.string(from: date)
    }
    
    static func load3LetterMonthName(timeStamp:Int64) -> String{
        let date = Date(milliseconds: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "MMM"
        return dateFormatter.string(from: date)
    }
    
    static func loadDate(timeStamp:Int64) -> String{
        let date = Date(milliseconds: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "d"
        return dateFormatter.string(from: date)
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
    
    static func compareDate (dates:[Int64], toCompareDate:Int64) -> Bool {
        let date = Date(milliseconds: toCompareDate)
        
        for d in dates {
            let tempDate = Date(milliseconds: d)
            let order = Calendar.current.compare(date, to: tempDate, toGranularity: .day)
            
            if order == .orderedSame {
                return true
            }
        }
        
        return false
    }
    
    static func MonthDayDateString (date : Date) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "MMMM, dd"
        
        let dateString1 = formatter.string(from: date)
        
        return "\(dateString1)"
    }
    
    static func MonthYearDateString (date : Date) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "MMMM YYYY"

        let dateString1 = formatter.string(from: date)
        
        return "\(dateString1)"
    }
    
    static func getDisplayForDateSelector (timeStamp : Int64) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "MMMM, dd"
        
        let date = Date(milliseconds: timeStamp)
        
        let dateString1 = formatter.string(from: date)
        
        return "\(dateString1)"
    }

    static func ObjectAsDictionary (object: Any) -> [String:Any] {
        let mirror = Mirror(reflecting: object)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
            guard let label = label else { return nil }
            let val = value
            
            return (label, val)
        }).compactMap { $0 })
        return dict
    }
    
    static func getDayForDayOfWeekInt (dayInt:Int) -> String {
        switch dayInt {
        case 0:
            return "SUNDAY"
        case 1:
            return "MONDAY"
        case 2:
            return "TUESDAY"
        case 3:
            return "WEDNESDAY"
        case 4:
            return "THURSDAY"
        case 5:
            return "FRIDAY"
        case 6:
            return "SATURDAY"
        default:
            return ""
        }
    }

}

extension String {
    subscript(i: Int) -> String {
        if !self.isEmpty {
            return String(self[index(startIndex, offsetBy: i)])
        } else {
            return ""
        }
    }
}
