//
//  BaseOffer.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import UIKit

public class BaseOffer: NSObject, SpecialOffer {
    
    public let uuid = NSUUID().uuidString.lowercased()
    
    public private(set) var name: String = Constants.nonameString
    
    init(withName name: String) {
        self.name = name
    }
    
    public func updateWithName(_ name: String) {
        self.name = name
    }
    
    public func description() -> String {
        return "Special offer: \(name)"
    }
    
    // WARNING:
    // It has to be overridden inside inherited objects.
    public func applyForTickets(_ tickets: inout [BaseTicket]) {
        let msg = String(format: "Special offer routine (\(name)) not implemented.", name)
        assert(false, msg)
    }
}
