//
//  Extra.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import UIKit

public class BaseExtra: BaseTE {
    
    public override func description() -> String {
        return String(format: "[+\(name) %@]", price.currencyString())
    }
}
