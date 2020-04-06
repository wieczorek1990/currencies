//
//  Globals.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 06/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

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
var tableSample = Table(table: "A",
                        no: "066/A/NBP/2020",
                        effectiveDate: "2020-04-03",
                        rates: [dolar, euro])
var ratesSample = Rates(table: "A", currency: "dolar amerykański", code: "USD", rates: [
    Rate(no: "066/A/NBP/2020", effectiveDate: "2020-04-03", mid: 4.2396, bid: nil, ask: nil),
    Rate(no: "066/A/NBP/2020", effectiveDate: "2020-04-04", mid: 4.2397, bid: nil, ask: nil)
])
