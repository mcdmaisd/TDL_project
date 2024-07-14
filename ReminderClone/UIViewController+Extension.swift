//
//  UIViewController+Extension.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-15.
//

import UIKit

extension UIViewController {
    
    func sendNotification(_ key: String) {
        NotificationCenter.default.post(name: NSNotification.Name(key), object: nil, userInfo: nil)
    }
}
