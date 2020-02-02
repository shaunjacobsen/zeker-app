//
//  TransactionView.swift
//  Zeker
//
//  Created by Shaun Jacobsen on 02/02/2020.
//  Copyright © 2020 Shaun Jacobsen. All rights reserved.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.cardColor).shadow(color: Color.shadowColor, radius: 10)
                TransactionDetailView(transaction: transaction)
            }
            .padding(20)
        }
        .frame(alignment: .top)
        .background(Color.backgroundColor)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(transaction: Transaction(name: "Sample", amount: 100.00, date: Date.init(), category: "category"))
    }
}

struct TransactionDetailView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TransactionDetailItemView(label: "ontvanger", value: transaction.name)
            TransactionDetailItemView(label: "categorie", value: transaction.category ?? "")
            TransactionDetailItemView(label: "transactiedatum", value: "date")
            Spacer()
            TransactionDetailItemView(label: "totaal", value: String(format: "%.2f", transaction.amount))
                
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 40)
    }
    
}

struct TransactionDetailItemView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label).font(.system(size: 20)).foregroundColor(Color.lightGrey)
            Text(value).fontWeight(.heavy).font(.system(size: 30))
            
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}
