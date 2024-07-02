//
//  ReuseId.swift
//  ReminderClone
//
//  Created by ilim on 2024-07-02.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var id: String { get }
}

extension UIViewController: ReuseIdentifierProtocol {
    static var id: String {
        String(describing: self)
    }
}

extension UITableViewCell {
    static var id: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var id: String {
        return String(describing: self)
    }
}
