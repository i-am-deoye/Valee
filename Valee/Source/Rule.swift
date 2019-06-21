//
//  Rule.swift
//  Valee
//
//  Created by Moses on 20/06/2019.
//  Copyright © 2019 IOpenSourced. All rights reserved.
//

import Foundation

public enum Rule  {
    case phoneNumber
    case amount
    case password
    case required
    case email
    case card
    
    public func validate(_ value: Any?, customRegex: CustomRegex?=nil) -> Bool {
        
        guard let guardValue = value else { return false }
        
        if let validatable = guardValue as? Validatable {
            return validatable.validate()
        }
        
        guard checkPrimitiveness(guardValue) else {
            assert(false, "value is neither primitive nor validatable type")
        }
        
        let stringValue = "\(guardValue)"
        
        if let regex = customRegex {
            let test = NSPredicate(format: "SELF MATCHES %@", regex)
            return test.evaluate(with: stringValue)
        }
        
        switch self {
        case .phoneNumber:
            return ValidateUtils.phone(stringValue)
        case .amount:
            return ValidateUtils.amount(stringValue)
        case .password:
            return false
        case .required:
            return ValidateUtils.required(stringValue)
        case .email:
            return ValidateUtils.email(stringValue)
        case .card:
            return ValidateUtils.card(stringValue)
        }
    }
    
    private func checkPrimitiveness(_ value: Any) -> Bool {
        return (value is Int || value is Double || value is Float || value is String)
    }
}
