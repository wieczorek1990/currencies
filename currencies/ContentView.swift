//
//  ContentView.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 03/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

import SwiftUI

struct Currency {
    let date: String;
    let name: String;
    let code: String;
    let mid: String;
}

let currenciesData = [
    [
        "date": "2020-04-01",
        "name": "dolar amerykański",
        "code": "USD",
        "mid": "3.82"
    ],
    [
        "date": "2020-04-01",
        "name": "euro",
        "code": "EUR",
        "mid": "4.82"
    ]
]

let currenciesDataStruct = [
    Currency(date: currenciesData[0]["date"]!,
             name: currenciesData[0]["name"]!,
             code: currenciesData[0]["code"]!,
             mid: currenciesData[0]["mid"]!),
    Currency(date: currenciesData[1]["date"]!,
             name: currenciesData[1]["name"]!,
             code: currenciesData[1]["code"]!,
             mid: currenciesData[1]["mid"]!),
]

struct TableRow: View {
    var currency: Currency
    init(currency: Currency) {
        self.currency = currency
    }
    func content() -> String {
        return self.currency.date + "; " + self.currency.name + "; " + self.currency.code + "; " + self.currency.mid
    }
    var body: some View {
        Text(self.content())
    }
}

struct TableView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            TableRow(currency: currenciesDataStruct[0])
            TableRow(currency: currenciesDataStruct[1])
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
