//
//  TOMainViewController.swift
//  ticketOffice
//
//  Created by Marcin Kosobudzki on 05/04/2019.
//  Copyright © 2019 Marcin Kosobudzki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isEditable = false
        let msg = prepareDemoOutput()
        textView.text = msg
        
        print(msg)
    }

    // because of device rotation, on small iPhone we should scroll to the top
    override func viewDidLayoutSubviews() {
        textView.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    private func prepareDemoOutput() -> String {
        var retValue = ""
        
        let tickets = [
            TicketStandard(),
            TicketConcession(),
            TicketStandard(withExtras: Set<BaseExtra>([ExtraReal3D()])),
            TicketConcession(withExtras: Set<BaseExtra>([ExtraReal3D(), ExtraIMAX()])),
            TicketStandard(),
            TicketStandard()
        ]

        let ttManager = TicketTotalsManager(withTickets: tickets)
        let specOffer = ThursdayOffer()
        
        retValue += "\nTickets before discount:\n\n"
        retValue += ttManager.description()
        
        retValue += "\n\nTickets after discount:"
        
        retValue += "\n\nToday is \(ThursdayOffer.currentDayOfWeek())."
        if !ThursdayOffer.isTodayThursday(canSimulate: false) && Constants.simulateIsThursday {
            retValue += "\nThursday will be simulated."
        }
        
        if ThursdayOffer.isTodayThursday(canSimulate: true) {
            retValue += "\nThe special offer '\(specOffer.name)' will be applied.\n\n"
            
            ttManager.addOffer(specOffer)
            ttManager.applyAllOffers()
            
            retValue += ttManager.description()
        } else {
            retValue += "\nThe special offer '\(specOffer.name)' can't be applied. Sorry.. :("
        }

        return retValue
    }
}

