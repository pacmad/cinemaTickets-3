//
//  ThursdayOffer.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import Foundation

public class ThursdayOffer: BaseOffer {
    
    class func isTodayThursday(canSimulate: Bool) -> Bool {
        if canSimulate && Constants.simulateIsThursday {
            return true
        }
        
        let today = Date()
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: today)
        
        // Sunday = 0, Moday = 1, ...
        return (components.weekday == 5)
    }
    
    class func currentDayOfWeek() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: today)
    }
    
    init() {
        super.init(withName: "Three for One Thursday")
    }
    
    public override func applyForTickets(_ tickets: inout [BaseTicket]) {
    
        guard ThursdayOffer.isTodayThursday(canSimulate: true) else {
            return
        }
        
        // first sort tickes frm highest to lowest price
        var sortedTickets = tickets.sorted(by: { $0.priceWithExtras() > $1.priceWithExtras() })
        var doneTickets = [String: BaseTicket]()
        while sortedTickets.count > 1 { // min. two tickets are required to apply rules
            
            // get higher price as it is
            var index = 0
            var key = sortedTickets[index].uuid
            doneTickets[key] = sortedTickets[index]
            sortedTickets.remove(at: index)
            
            // try to add discount to the last two tickets (the cheapest)
            for _ in 1...2 {
                if let lastTicket = sortedTickets.last {
                    lastTicket.updateDiscountWithPercentValue(100)
                    
                    index = sortedTickets.count-1
                    key = sortedTickets[index].uuid
                    doneTickets[key] = sortedTickets[index]
                    sortedTickets.remove(at: index)
                }
            }
        }

        // if there were left something (sometimes one ticket can be left)
        // move the rest to done tickets
        while sortedTickets.count > 0 {
            let index = 0
            let key = sortedTickets[index].uuid
            doneTickets[key] = sortedTickets[index]
            sortedTickets.remove(at: index)
        }
        
        // restore old ticket order
        for ticket in tickets {
            let key = ticket.uuid
            if let discountedTicket = doneTickets[key] {
                let discountPercent = discountedTicket.discount
                ticket.updateDiscountWithPercentValue(discountPercent)
            }
        }
    }
}
