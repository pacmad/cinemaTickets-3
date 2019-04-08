//
//  Stirng+Decorator.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 08/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import Foundation

extension Double {
    
    // for simplicity I assume that the only possible currency is pound
    public func currencyString() -> String {
        return String(format:"%@%.2f", Constants.currencySymbol, self)
    }

}
