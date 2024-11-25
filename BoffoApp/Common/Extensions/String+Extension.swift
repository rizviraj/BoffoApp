//
//  String+Extension.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation

extension String{
  
    var isValidText: Bool{
        return self.count > 2
    }
    var isBasicValidText: Bool{
        return self.count > 1
    }
    var isValidPassword: Bool{
        return self.count > 6
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
}
