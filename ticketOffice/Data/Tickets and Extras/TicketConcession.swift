//
//  TicketConcession.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 08/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import UIKit

public class TicketConcession: BaseTicket {

    init() {
        super.init(withName: "Concession", price: 5.40)
    }
    
    convenience init(withExtras extras: Set<BaseExtra>) {
        self.init()
        self.replaceExtrasWith(extras)
    }
}
