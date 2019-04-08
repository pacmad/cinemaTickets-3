//
//  BaseTicket.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import Foundation

// Base class for tickets (T) and extensions (E)
public class BaseTE: NSObject {
    
    public let uuid = NSUUID().uuidString.lowercased()
    
    public private(set) var name: String = Constants.nonameString
    public private(set) var price: Double = 0.0
    
    init(withName name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    public func updateWithName(_ name: String) {
        self.name = name
    }
    
    public func updateWithPrice(_ price: Double) {
        self.price = price
    }
    
    public func description() -> String {
        return String(format: "\(name) (%@)", price.currencyString())
    }
}
