//
//  ContentView.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 03/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

import SwiftUI

var tables = ["A", "B", "C"]
var dolar = Currency(currency: "dolar amerykański",
                     code: "USD",
                     mid: 4.2396,
                     bid: nil,
                     ask: nil)
var euro = Currency(currency: "euro",
                    code: "EUR",
                    mid: 4.5792,
                    bid: nil,
                    ask: nil)
var table = Table(
    table: "A",
    no: "066/A/NBP/2020",
    effectiveDate: "2020-04-03",
    rates: [dolar, euro])

struct TableRow: View {
    var table: Table
    var currency: Currency
    init(table: Table, currency: Currency) {
        self.table = table
        self.currency = currency
    }
    func content() -> String {
        return self.table.effectiveDate + "; " + self.currency.currency + "; " + self.currency.code + "; " + String(format: "%.2f", self.currency.middle())
    }
    var body: some View {
        Text(self.content())
    }
}

struct TableView: View {
    var table: Table
    init(table: Table) {
        self.table = table
    }
    func unpack(data: [Currency]) -> [TableRow] {
        var result = [TableRow]()
        for row in data {
            result.append(TableRow(table: self.table, currency: row))
        }
        return result
    }
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            List(table.rates, id: \.code) { currency in
                    NavigationLink(destination: CurrencyDetail(currency: currency)) {
                        TableRow(table: self.table, currency: currency)
                }
            }
        }
    }
}

struct ContentView: View {
    @State var selectedTable : Int = 0
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: nil, content: {
                Picker(selection: $selectedTable, label: Text("Table")) {
                    ForEach(0 ..< tables.count) {
                        Text(tables[$0])
                    }
                }
                .onReceive([self.selectedTable].publisher.first()) { (value) in
                    let selectedTableValue = tables[value]
                    let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/\(selectedTableValue)/?format=json")!
                    print("Querying \(url)")
                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else { return }
                        let json = String(data: data, encoding: .utf8)!
                        do {
                            let result = try JSONDecoder().decode(Array<Table>.self, from: json.data(using: .utf8)!)
                            table = result[0]
                        } catch {
                            print(error)
                        }
                    }

                    task.resume()
                }
                TableView(table: table)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
