//
//  Valee.swift
//  Valee
//
//  Created by Moses on 20/06/2019.
//  Copyright © 2019 IOpenSourced. All rights reserved.
//

import Foundation


public struct RegisterValues {
    public struct Registry {
        public let rules : [[Rule:CustomRegex?]]
        public let value : Any?
        
       public init(_ rules: [[Rule:CustomRegex?]], value: Any?) {
            self.rules = rules
            self.value = value
        }
        
        func validate() -> Bool {
            let count = rules.filter({ (object) in
                let rule = object.keys.first!
                let regex = object.values.first
                return rule.validate(value, customRegex: regex ?? nil)
            }).count
            
            return count == rules.count
        }
    }
    
    
    public let values : [Registry]
    public init(_ values : [Registry]) {
        self.values = values
    }
}

public protocol Validatable {
    var registerValues : RegisterValues { get }
}

public extension Validatable {
    func validate() -> Bool {
        let count = registerValues.values.filter({ $0.validate() == true }).count
        return count == registerValues.values.count
    }
}
