//
//  TicketStandard.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 08/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import UIKit

public class TicketStandard: BaseTicket {
    
    init() {
        super.init(withName: "Standard", price: 7.90)
    }
    
    convenience init(withExtras extras: Set<BaseExtra>) {
        self.init()
        self.replaceExtrasWith(extras)
    }
}
