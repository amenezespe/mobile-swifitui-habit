//
//  String+Extension.swift
//  Habit
//
//  Created by Arthur Menezes on 2024-03-06.
//

import SwiftUI

extension String {
    
    func isEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
        
    }
    
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            
            cur = cur + 1
        }
        
       return nil
    }
    
    func toDate(sourcePattern source: String, destPattern dest: String) -> String? {
       //converter datas
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        let dateFormatted = formatter.date(from: self)
        guard let dateFormatted = dateFormatted else {
            return nil
        }
        
        formatter.dateFormat = dest
        return formatter.string(from: dateFormatted)
    }
    
    
    func toDate(sourcePattern source: String) -> Date? {
       //converter datas
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = source
        
        return formatter.date(from: self)
    }
}
