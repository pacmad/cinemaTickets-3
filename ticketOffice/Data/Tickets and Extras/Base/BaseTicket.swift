//
//  Ticket.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 04/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import Foundation

public class BaseTicket: BaseTE {
    
    // e.g. Real3D, IMAX
    public private(set) var extras = Set<BaseExtra>()
    
    // Ticket discount in percents.
    // E.g. 10 means 10% discount, 100 means 100% discount i.e. free ticket
    public private(set) var discount: UInt = 0
    
    convenience init(withName name: String, price: Double, extras: Set<BaseExtra>) {
        self.init(withName: name, price: price)
        self.extras = extras
    }
    
    public func replaceExtrasWith(_ extras: Set<BaseExtra>) {
        self.extras = extras
    }
    
    public func addExtras(_ extras: Set<BaseExtra>) {
        self.extras = self.extras.union(extras)
    }
    
    public func addExtra(_ extra: BaseExtra) {
        self.extras.insert(extra)
    }
    
    public func removeExtras(_ extras: Set<BaseExtra>) {
        self.extras = self.extras.subtracting(extras)
    }
    
    public func removeExtra(_ extra: BaseExtra) {
        self.extras.remove(extra)
    }
    
    public func removeAllExtras() {
        self.extras.removeAll()
    }
    
    // Give value in percent, e.g.: 10, 30, 100
    public func updateDiscountWithPercentValue(_ value: UInt) {
        self.discount = (value > 100) ? 100 : value
    }
    
    // Return summarized price: ticket + all extras (without any discount).
    public func priceWithExtras() -> Double {
        var retValue = price
        for item in extras {
            retValue += item.price
        }
        
        return retValue
    }
    
    // Return summarized ticket price included discount: (ticket + all extras) * discount %.
    public func priceWithExtrasAndDiscount() -> Double {
        let retValue = priceWithExtras()
        let discountValue = retValue * (Double(discount) / 100.0)
        return retValue - discountValue
    }
    
    public override func description() -> String {
        var additions: String {
            var retValue = ""
            for extra in self.extras {
                retValue += extra.description()
            }
            return retValue
        }
        
        let totalPrice = priceWithExtras()
        let totalPriceWithDiscount = priceWithExtrasAndDiscount()
        
        return super.description() + " " + additions
            + String(format: "  total: %@,", totalPrice.currencyString())
            + String(format: "  with discount (%d%%): %@", discount, totalPriceWithDiscount.currencyString())
    }
}
