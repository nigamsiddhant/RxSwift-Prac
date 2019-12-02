//
//  UIUtility.swift
//  Matrix
//
//  Created by Siddhant Nigam on 02/12/19.
//  Copyright © 2019 Siddhant Nigam. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

struct MyString {
    static func blank(text: String) -> Bool {
        let trimmed = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
}

class UIUtility {
    
    class func addInputAccessoryTextInput(_ input: UIView, onViewController viewController: UIViewController, action: Selector) {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: viewController, action: action)
        toolbar.items = [flexButton, doneButton]
        if let textView = input as? UITextView {
            textView.inputAccessoryView = toolbar
        }
        
        if let textFieldView = input as? UITextField {
            textFieldView.inputAccessoryView = toolbar
        }
    }
    
    static func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    static func showErrorAlert(_ title: String, message: String, duration: TimeInterval? = nil){
        let view: MessageView
        do {
            view = try SwiftMessages.viewFromNib()
            view.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
            let iconStyle: IconStyle
            iconStyle = .default
            view.configureTheme(.error, iconStyle: iconStyle)
            view.accessibilityPrefix = "error"
            view.configureDropShadow()
            view.button?.isHidden = true
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            config.duration = .seconds(seconds: duration ?? 1)
            config.shouldAutorotate = false
            config.interactiveHide = true
            config.preferredStatusBarStyle = .lightContent
            // Show
            SwiftMessages.show(config: config, view: view)
        } catch let error {
            print(error)
        }
    }
    
    static func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    static func showWarningAlert(_ title: String, message: String, duration: TimeInterval? = nil, presentationStyle: SwiftMessages.PresentationStyle? = nil){
        let view: MessageView
        do {
            view = try SwiftMessages.viewFromNib()
            view.configureContent(title: title, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
            let iconStyle: IconStyle
            iconStyle = .default
            view.configureTheme(.warning, iconStyle: iconStyle)
            view.accessibilityPrefix = "warning"
            view.configureDropShadow()
            view.button?.isHidden = true
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            if let type = presentationStyle{
                config.presentationStyle = type
            }
            config.duration = .seconds(seconds: duration ?? 1)
            config.shouldAutorotate = false
            config.interactiveHide = true
            config.preferredStatusBarStyle = .lightContent
            // Show
            SwiftMessages.show(config: config, view: view)
        } catch let error {
            print(error)
        }
    }
}
