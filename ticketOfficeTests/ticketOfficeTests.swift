//
//  ticketOfficeTests.swift
//  ticketOfficeTests
//
//  Created by Marcin Kosobudzki on 04/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import XCTest
@testable import ticketOffice

class ticketOfficeTests: XCTestCase {

    var tickets: [BaseTicket]!
    var specOffers: Set<BaseOffer>!
    var ticketTotalManager: TicketTotalsManager!
    
    override func setUp() {
        tickets = [BaseTicket]()
        specOffers = Set<BaseOffer>()
        ticketTotalManager = TicketTotalsManager()
    }

    override func tearDown() {
        tickets.removeAll()
        specOffers.removeAll()
        ticketTotalManager.removeAllTickets()
        ticketTotalManager.removeAllOffers()
        
        tickets = nil
        specOffers = nil
        ticketTotalManager = nil
    }

    func testThatSumOfTicketPricesWithoutDiscountIsCorrect() {
        tickets.append(contentsOf: [
            TicketStandard(),
            TicketStandard(),
            TicketStandard()
        ])

        let onePrice = tickets[0].price
        let correctSum = onePrice * 3
        
        Constants.simulateIsThursday = false
        ticketTotalManager.addTickets(tickets)
        let computedSum = ticketTotalManager.totalPriceWithoutDiscounts()
        
        XCTAssert(computedSum == correctSum, "Incorect computed sum of ticket prices (no applied).")
    }
    
    // This test check whether two tickets will be for free.
    func testThatSumOfTicketPricesWithDiscountIsCorrect() {
        tickets.append(contentsOf: [
            TicketStandard(),
            TicketStandard(),
            TicketStandard(),
            TicketStandard()
            ])
        
        let onePrice = tickets[0].price
        let correctSum = onePrice * 2 // because 2 should be free
        
        Constants.simulateIsThursday = true
        let specOffer = ThursdayOffer()
        
        ticketTotalManager.addTickets(tickets)
        ticketTotalManager.addOffer(specOffer)
        ticketTotalManager.applyAllOffers()
        let computedSum = ticketTotalManager.totalPriceWithDiscounts()
        
        XCTAssert(computedSum == correctSum, "Incorect computed sum of ticket prices (discount applied).")
    }
    
    // This test check whether the highest price is choosen to pay and lower prices are taken for discounts.
    func testThatHighestPriceIsSelectedForDiscount() {
        tickets.append(contentsOf: [
            TicketConcession(),
            TicketStandard(),
            TicketStandard(withExtras: Set<BaseExtra>([ExtraReal3D()]))
            ])
        
        let highestPrice = tickets[2].priceWithExtras()
        
        Constants.simulateIsThursday = true
        let specOffer = ThursdayOffer()
        
        ticketTotalManager.addTickets(tickets)
        ticketTotalManager.addOffer(specOffer)
        ticketTotalManager.applyAllOffers()
        let computedSum = ticketTotalManager.totalPriceWithDiscounts()
        
        XCTAssert(computedSum == highestPrice, "Highest price not choosen for discount.")
    }
    
}
