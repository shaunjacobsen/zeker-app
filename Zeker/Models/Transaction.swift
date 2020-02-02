//
//  Transaction.swift
//  Zeker
//
//  Created by Shaun Jacobsen on 02/02/2020.
//  Copyright © 2020 Shaun Jacobsen. All rights reserved.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let date: Date
    let transactionDate: Date? = nil
    let category: String?
    let notes: String? = nil
    
    func isDebit() -> Bool {
        return amount < 0
    }
}

extension Transaction {
    static func all() -> [Transaction] {
        return [
            Transaction(name: "Transaction 1", amount: 10.00, date: Date(), category: "Boodschappen"),
            Transaction(name: "Transaction 2", amount: -10.00, date: Date(), category: "Boodschappen")
        ]
    }
}
