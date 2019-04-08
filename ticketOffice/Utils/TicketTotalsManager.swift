//
//  TicketTotalsManager.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import Foundation

class TicketTotalsManager {

    public private(set) var tickets = [BaseTicket]()
    public private(set) var offers = Set<BaseOffer>()
    
    convenience init(withTickets tickets: [BaseTicket]) {
        self.init()
        self.tickets = tickets
    }
    
    convenience init(withTickets tickets: [BaseTicket], andOffers offers: Set<BaseOffer>) {
        self.init()
        self.tickets = tickets
        self.offers = offers
    }
    
    public func addTicket(_ ticket: BaseTicket) {
        self.tickets.append(ticket)
    }
    
    public func addTickets(_ tickets: [BaseTicket]) {
        self.tickets.append(contentsOf: tickets)
    }
    
    public func addOffer(_ offer: BaseOffer) {
        self.offers.insert(offer)
    }
    
    public func addOffers(_ offers: Set<BaseOffer>) {
        self.offers = self.offers.union(offers)
    }
    
    public func removeAllTickets() {
        self.tickets.removeAll()
    }
    
    public func removeAllOffers() {
        self.offers.removeAll()
    }
    
    public func applyOffer(_ offer: BaseOffer) {
        if offers.contains(offer) {
            offer.applyForTickets(&self.tickets)
        }
    }
    
    public func applyAllOffers() {
        for offer in offers {
            offer.applyForTickets(&self.tickets)
        }
    }
    
    public func totalPriceWithoutDiscounts() -> Double {
        var totalPrice = 0.0
        
        for ticket in tickets {
            totalPrice += ticket.priceWithExtras()
        }
        
        return totalPrice
    }
    
    public func totalPriceWithDiscounts() -> Double {
        var totalPrice = 0.0
        
        for ticket in tickets {
            totalPrice += ticket.priceWithExtrasAndDiscount()
        }
        
        return totalPrice
    }
    
    public func description() -> String {
        var retValue = ""
        var counter = 0
       
        // list of all tickets
        for ticket in tickets {
            counter += 1
            retValue += String(format: "\n%d. %@", counter, ticket.description())
        }
        
        let totalPriceNoDiscounts = totalPriceWithoutDiscounts()
        let totalPricePlusDiscounts = totalPriceWithDiscounts()
        let totalSaved = totalPriceNoDiscounts - totalPricePlusDiscounts
        retValue += "\n\n******\ntotal price w/o discounts: \(totalPriceNoDiscounts.currencyString())\ntotal price with discounts: \(totalPricePlusDiscounts.currencyString())\nuser will save: \(totalSaved.currencyString())\n"
        
        return retValue
    }
}
