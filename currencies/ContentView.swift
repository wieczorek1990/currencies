//
//  ContentView.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 03/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

import SwiftUI

struct Currency {
    let name: String
    let code: String
    let mid: String
}

struct Table {
    let table: String
    let no: String
    let effectiveDate: String
    let rates: Array<Currency>
}

let table = Table(
    table: "A",
    no: "066/A/NBP/2020",
    effectiveDate: "2020-04-03",
    rates: [
        Currency(name: "dolar amerykański",
                 code: "USD",
                 mid: "3.82"),
        Currency(name: "euro",
                 code: "EUR",
                 mid: "4.82"),
    ])

struct TableRow: View {
    var table: Table
    var currency: Currency
    init(table: Table, currency: Currency) {
        self.table = table
        self.currency = currency
    }
    func content() -> String {
        return self.table.effectiveDate + "; " + self.currency.name + "; " + self.currency.code + "; " + self.currency.mid
    }
    var body: some View {
        Text(self.content())
    }
}

struct TableView: View {
    func unpack(data: [Currency]) -> [TableRow] {
        var result = [TableRow]()
        for row in data {
            result.append(TableRow(table:table, currency: row))
        }
        return result
    }
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            List(table.rates, id: \.code) { currency in
                TableRow(table: table, currency: currency)
            }
        }
    }
}

struct ContentView: View {
    var tables = ["A", "B", "C"]
    @State private var selectedTable : Int = 0;
    var body: some View {
        VStack(alignment: .leading, spacing: nil, content: {
            Picker(selection: $selectedTable, label: Text("Table")) {
                ForEach(0 ..< tables.count) {
                    Text(self.tables[$0])
                }
            }
            TableView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
