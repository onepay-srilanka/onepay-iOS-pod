//
//  UtilityExtension.swift
//  OnepayIPG
//
//  Created by amilla fernando on 2022-07-04.
//

import Foundation

extension String{
    
    func isAValidPhone() -> Bool{
        
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[+94]7[0,1,2,4,5,6,7,8][0-9]{7}")
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
    
    
    func isValidEmail() -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension Data{
    
    func toString() -> String?
    {
        return String(data: self, encoding: .utf8)
    }
}
