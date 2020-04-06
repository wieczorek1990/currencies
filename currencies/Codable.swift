//
//  Codable.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 06/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

struct Currency: Codable {
    let currency: String
    let code: String
    let mid: Float?
    let bid: Float?
    let ask: Float?
    func middle() -> Float {
        if (mid == nil) {
            return (self.bid! + self.ask!) / 2
        }
        return mid!
    }
}

struct Table: Codable {
    let table: String
    let no: String
    let effectiveDate: String
    let rates: Array<Currency>
}

struct Rate: Codable {
    let no: String
    let effectiveDate: String
    let mid: Float?
    let bid: Float?
    let ask: Float?
    func middle() -> Float {
        if (mid == nil) {
            return (self.bid! + self.ask!) / 2
        }
        return mid!
    }
}

struct Rates: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: Array<Rate>
    
    func format() -> String {
        var result = ""
        result += "Table: \(table)\n"
        result += "Currency: \(currency)\n"
        result += "Code: \(code)\n"
        rates.forEach { rate in
            result += "\(rate.no); \(rate.effectiveDate); \(String(format: "%.2f", rate.middle()))\n"
        }
        return result
    }
}
