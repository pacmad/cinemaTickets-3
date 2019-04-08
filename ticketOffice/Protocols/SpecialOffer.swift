//
//  SpecialOffer.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

public protocol SpecialOffer {    
    
    func applyForTickets(_ tickets: inout [BaseTicket])
}
