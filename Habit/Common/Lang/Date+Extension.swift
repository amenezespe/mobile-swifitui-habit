//
//  Date+Extension.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-19.
//

import Foundation
import SwiftUI

extension Date {
    func toString (destParttern dest: String) -> String {
       
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = dest
        
        return formatter.string(from: self)
    }
}
