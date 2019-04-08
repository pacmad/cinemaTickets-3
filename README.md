# ticketOffice
Ticket Office Exercise
Unit Test included.

## Build instructions:
The project doesn't include any Pods or external libs, so just run project to see results.
If you are using iPhone, you can use landscape position to see more chars in one line.
For iPads, it doesn't matter.

## Exercise description (short):
Please see the last note at the end of this document.

## Preliminary assumptions:
1. Because the UI was not the point of this exercise, I used simple UITextView to show output.
2. Some sample data are loaded when `ViewController` starts, because there is no input interface.
3. If you wish, you can add or remove sample data in  `prepareDemoOutput()` method of VC.

## Special offer: 3 for 1 Thursdays
This was  one of two the biggest challenges to me. How to find the way, which tickets should be free and which should be paid. 
The test description doesn't clarify it:
* Should the three tickets be exactly the same?
* Can I pay for any of these three tickets, and then take any two additional (even more expensive)?
* What about different extras?
* What if one ticket is Standard and second is Concession?
* etc..

Well, this is why I assumed that the user always has to pay for the more expensive ticket to receive the next two free. So, the algorithm is that first, we sort all tickets from the highest price to lowest. Then for we pull one ticket from the top (highest price) and then we can take up to two tickets from the bottom (end of the sorted array, the lowest price). This rule is repeated until we have one or zero tickets left. And it works :)
BTW, when tickets are sorting, the price with extras is taken.

## Other notes
1. Any new ticket type or extra feature can be added. Just inherit a new class from `BaseTicket` or `BaseExtra`.
2. Also, you can add any new special offer by inheriting from `BaseOffer` and implementing `SpecialOffer` protocol.
3. You can set  `Constants.simulateIsThursday` to `true` to simulate Thursday for everyday. If you set it to `false` then have to manually change date in Mac Os / iOS to see that special offer (3 for 1 Thursday) will be applied.

## What could be better?
1. There was not too much time, so many things were simplified (like UI). Of course entire GUI should be made.
2. Auto-apply special offer should be writen in a bit different way, but it was simplier to me to manually invoke `applyForTickets(_:)`.
3. More UI Tests. I created only a few samples.


------------------------------------------------
## Exercise description (full):
------------------------------------------------

Cinema Tickets Exercise

Please think carefully about each aspect of the problem and define a solution that fits the requirements listed. Answers can be written in a language of your choice or pseudo code. A complete solution to the problem is not required and a UI is not expected in the allotted time frame.

Write down any assumptions you make or things you would do differently in a production system.
As a guide this test should take approximately 2 hours.

A cinema requires a new ticketing system to be used in their shiny new app. There are two types of ticket:
● Standard: £7.90
● Concession: £5.40

In addition there are a few extras which can be added to some tickets:
● Real3D: £0.90
● IMAX: £1.50

The Cinema also wants to have special offers that are applied automatically. A specific offer they would like to include from the start is:
● Three for One Thursdays (buy one get two free for tickets purchased on Thursdays)

Ticket Totaling:
-----------------
Your task is to implement a checkout system that can calculate the total cost of a combination of tickets that a user might buy using the app. Bear in mind:
● Tickets can be added in any order
● Offers should always be applied if possible
● The cinema owner would like to show the customer how much they saved when offers
have been applied
● New types of pricing/offers may need to be added in the future

