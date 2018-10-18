//
//  Utilities.swift
//  i Trust You
//
//  Created by Nerudo Mregi on 2017/02/13.
//  Copyright © 2017 Bsolve. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    func hideBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
extension Data {
    func hexString() -> String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
    func castToCPointer<T>() -> T {
        return self.withUnsafeBytes { $0.pointee }
    }
    func write(withName name: String) -> URL {
        
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        
        try! write(to: url, options: .atomicWrite)
        
        return url
    }
}
public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}
extension String {
    func isStringLink() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) { cString.removeFirst() }
        
        if ((cString.count) != 6) {
            self.init(hex: "ff0000") // return red color for wrong hex input
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
}
// Put this piece of code anywhere you like
extension UIViewController {
   
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
    func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    func showAlert(title: String = "Oops!", message: String, isModal : Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if isModal {
            show(alertController, sender: nil)
            return
        }
        topMostController().present(alertController, animated: true, completion: nil)
    }
    
}

extension UIViewController: UITextFieldDelegate {
    func addToolBar(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76 / 255, green: 217 / 255, blue: 100 / 255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    @objc func cancelPressed() {
        view.endEditing(true) // or do something
    }
}
func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}
extension NSDate {
    var stringValue: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S"
        return formatter.string(from: self as Date)
    }
}
extension String{
    func toDate(format : String) -> Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
}

func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == now as Date) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1y"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "Today"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1h"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1m"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }
    
}
extension String {
    var parseJSONString: Any? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let jsonData = data else { return nil }
        do { return try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) }
        catch { return nil }
    }
    var dateFromString: NSDate?{
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let s = dateFormatter.date(from: dateString)
        do{
            return s as! NSDate
        }
    }
}
extension UILabel {
     @objc public var _substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
}

extension UITextView {
    @objc public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 14)
        }
    }
}

extension UITextField {
    @objc public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 14)
        }
    }
}
extension NSAttributedStringKey {
    static let myName = NSAttributedStringKey(rawValue: "myCustomAttributeKey")
}
extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   == 1 { return "\(years(from: date)) year"   } else if years(from: date)   > 1 { return "\(years(from: date)) years"   }
        if months(from: date)  == 1 { return "\(months(from: date)) month"  } else if months(from: date)  > 1 { return "\(months(from: date)) month"  }
        if weeks(from: date)   == 1 { return "\(weeks(from: date)) week"   } else if weeks(from: date)   > 1 { return "\(weeks(from: date)) weeks"   }
        if days(from: date)    == 1 { return "\(days(from: date)) day"    } else if days(from: date)    > 1 { return "\(days(from: date)) days"    }
        if hours(from: date)   == 1 { return "\(hours(from: date)) hour"   } else if hours(from: date)   > 1 { return "\(hours(from: date)) hours"   }
        if minutes(from: date) == 1 { return "\(minutes(from: date)) minute" } else if minutes(from: date) > 1 { return "\(minutes(from: date)) minutes" }
        return ""
    }
}
