//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    // retrieves name of item
    var name : String { get }
    // returns price of item in usd pennies
    func price() -> Int
}

// implements SKU and uses a price-per-item pricing scheme. That is to say, a $4.99 can of beans (an Item("Beans", 499)) 
// or a $.99 pencil (an Item("Pencil", 99)).
class Item : SKU {
    let name: String
    let priceEach: Int

    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEach = priceEach
    }

    func price() -> Int {
        return self.priceEach
    }
}

// The Receipt is a list of the entire transaction.
// Implement an items method that returns the list of SKUs that were scanned.
// Implement an output method to print out all of the items stored on the Receipt.
class Receipt {
    var listItems: [SKU]
    init() {
        self.listItems = []
    }
    
    // adds item to array of items
    func scan(_ item: SKU) {
        self.listItems.append(item)
    }

    // returns array of items
    func items() -> [SKU] {
        return self.listItems
    }

    // returns the total of the items in the array as an int
    func total() -> Int {
        var total = 0
        self.listItems.forEach { item in
            total += item.price()
        }
        return total
    }
    
    // a total function i made that converts the items to a string
    func totalString() -> String {
        var total = 0
        self.listItems.forEach { item in
            total += item.price()
        }
        let calcTotal = Double(total) / 100.0
        let totalString = String(format: "%.2f", calcTotal)
        return totalString
    }

    func output() -> String {
        var printReceipt = ""
        printReceipt += "Receipt:\n"
        self.listItems.forEach { item in
            let itemPrice = String(format: "%.2f", Double(item.price()) / 100.0)
            printReceipt += "\(item.name): $\(itemPrice)\n"
        }
        printReceipt += "------------------\n"
        let totalString = totalString()
        printReceipt += "TOTAL: $\(totalString)"
        return printReceipt
    }
}

// The Register is responsible for displaying the total along the way, so you need to:
// Implement a subtotal method that returns the current total for all the items on the Receipt.
// Implmement a total method that returns the Receipt (which contains all the items scanned), and 
// clears its state to start a new Receipt. (In other words, subtotal displays the price along the way, 
// whereas total is the finished transaction.)
class Register {
    var receipt : Receipt

    init() {
        // empty receipt
        self.receipt = Receipt()
    }

    func scan(_ item: SKU) {
        receipt.scan(item)
    }

    func subtotal() -> Double {
        return Double(receipt.total())
    }
    
    func total() -> Receipt {
        // receipt, clears state to start new receipt
        let receiptOutput = receipt
        let receiptOutputTotal = receiptOutput.total()
        self.receipt = Receipt()
        return receiptOutput
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

