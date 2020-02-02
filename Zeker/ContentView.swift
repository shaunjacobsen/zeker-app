//
//  ContentView.swift
//  Zeker
//
//  Created by Shaun Jacobsen on 02/02/2020.
//  Copyright © 2020 Shaun Jacobsen. All rights reserved.
//

import SwiftUI

struct BalanceSlider: View {
    @Binding var sliderDate: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.amsterdamGrey)
                    .frame(height: 5)
                Rectangle()
                    .foregroundColor(.zekerGreen)
                    .frame(width: CGFloat(self.sliderDate), height: 5)
                Circle()
                    .fill(Color.white)
                    .foregroundColor(.zekerGreen)
                    .offset(x: CGFloat(self.sliderDate))
                    .frame(width: 30, height: 30)
                    .overlay(
                        Circle()
                            .stroke(Color.zekerGreen, lineWidth: 5)
                            .offset(x: CGFloat(self.sliderDate))
                    )
                
            }.frame(height: 50).cornerRadius(12)
                .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                    if !(value.location.x > geometry.size.width - 30 || value.location.x < 0) {
                        self.sliderDate = Float(value.location.x)
                    }
                    
                }))
        }
    }
}

struct BalanceView: View {
    @State var balance: Float = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.zekerGreen).shadow(color: Color.shadowColor, radius: 10)
                VStack(alignment: .leading) {
                    Text("1,000").fontWeight(.heavy).font(.system(size: 30)).foregroundColor(Color.white)
                    Text("on monday, 3 february").font(.system(size: 16)).foregroundColor(Color.zekerGreenDark)
                }
                .padding([.top, .bottom], 30)
                .padding([.leading, .trailing], 20)
            }
            .padding(20)
            .frame(maxHeight: 132)
            .zIndex(1)
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.white).shadow(color: Color.shadowColor, radius: 10)
                VStack {
                    BalanceSlider(sliderDate: $balance)
                    HStack {
                        Text("today").foregroundColor(Color.lightGrey).font(.system(size: 14))
                        Spacer()
                        Text("25 feb").foregroundColor(Color.lightGrey).font(.system(size: 14))
                    }.offset(y: -10)
                    
                }
                .padding(.top, 50)
                .padding([.leading, .trailing], 20)
                
            }
            .offset(y: 72)
            .padding(20)
            .frame(maxHeight: 160)
            .zIndex(0)
        }
        .padding(.bottom, 70)
        
    }
}


struct ContentView: View {
    let transactions: [Transaction] = Transaction.all()
    
    var body: some View {
        NavigationView {
            VStack {
                BalanceView()
                TransactionList(transactions: transactions)
            }
            .navigationBarTitle("Transactions")
            Color.backgroundColor.edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TransactionList: View {
    let transactions: [Transaction]
    
    var body: some View {
        List(transactions, id: \.name) { transaction in
            NavigationLink(destination: TransactionView(transaction: transaction)) {
                TransactionCell(transaction: transaction)
            }
        }
    }
}

struct TransactionCell: View {
    let transaction: Transaction
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }
    
    func formatCurrency(amount: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: amount))!
    }
    
    var body: some View {
        HStack {
            Text("💶").font(.system(size: 30)).padding(.trailing, 20)
            VStack(alignment: .leading) {
                Text(transaction.name).fontWeight(.bold)
                Spacer()
                Text(formatDate(date: transaction.date))
            }
            Spacer()
            Text(formatCurrency(amount: transaction.amount)).foregroundColor(transaction.isDebit() ? Color.firePink : Color.zekerGreen)
        }
        .padding(20)
        
    }
}
