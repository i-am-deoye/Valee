//
//  Regex.swift
//  Valee
//
//  Created by Moses on 20/06/2019.
//  Copyright © 2019 IOpenSourced. All rights reserved.
//

import Foundation

public typealias CustomRegex = String
public enum Regex : String {
    case phone = "^[0-9+]{0,1}+[0-9]{5,16}$"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

public enum CardRegex : String {
    case amex = "^3[47][0-9]{13}$"
    case bcGlobal = "^(6541|6556)[0-9]{12}$"
    case carteBlanche = "^389[0-9]{11}$"
    case dinersClub = "^3(?:0[0-5]|[68][0-9])[0-9]{11}$"
    case discovery = "^65[4-9][0-9]{13}|64[4-9][0-9]{13}|6011[0-9]{12}|(622(?:12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10})$"
    case instaPayment = "^63[7-9][0-9]{13}$"
    case jcb = "^(?:2131|1800|35\\d{3})\\d{11}$"
    case koreanLocal = "^9[0-9]{15}$"
    case laser = "^(6304|6706|6709|6771)[0-9]{12,15}$"
    case maestro = "^(5018|5020|5038|6304|6759|6761|6763)[0-9]{8,15}$"
    case master = "^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))$"
    case solo = "^(6334|6767)[0-9]{12}|(6334|6767)[0-9]{14}|(6334|6767)[0-9]{15}$"
    case `switch` = "^(4903|4905|4911|4936|6333|6759)[0-9]{12}|(4903|4905|4911|4936|6333|6759)[0-9]{14}|(4903|4905|4911|4936|6333|6759)[0-9]{15}|564182[0-9]{10}|564182[0-9]{12}|564182[0-9]{13}|633110[0-9]{10}|633110[0-9]{12}|633110[0-9]{13}$"
    case unionPay = "^(62[0-9]{14,17})$"
    case visaCard = "^4[0-9]{12}(?:[0-9]{3})?$"
    case visaMaster = "^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$"
    
    static func regexes() -> [CardRegex] {
        return [.amex, .bcGlobal, .carteBlanche, .dinersClub, .discovery, .instaPayment, .jcb, .koreanLocal, .laser, .maestro, .master, .solo, .switch, .unionPay, .visaCard, .visaMaster]
    }
}

public var AMOUNT_LIMIT_MAX : Double = 10_000_000.00
public var AMOUNT_LIMI_MIN : Double = 0.00

public struct ValidateUtils {
    public static func required(_ value: String) -> Bool {
        return !value.replacingOccurrences(of: " ", with: "").isEmpty || (Double(value) ?? 0) > 0
    }
    
    public static func card(_ value: String) -> Bool {
        let values = CardRegex.regexes().filter({ NSPredicate(format: "SELF MATCHES %@", $0.rawValue).evaluate(with: value) })
        return !values.isEmpty
    }
    
    public static func email(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
        return test.evaluate(with: value)
    }
    
    public static func phone(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
        return test.evaluate(with: value)
    }
    
    public static func amount(_ value: String) -> Bool {
        guard let amountValue = Double(value) else { return false }
        guard amountValue > AMOUNT_LIMI_MIN else { return false }
        guard amountValue < AMOUNT_LIMIT_MAX else { return false }
        return true
    }
}
