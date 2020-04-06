//
//  CurrencyDetail.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 04/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

import SwiftUI

func formatDate(date: Date) -> String {
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy-MM-dd"
    return dateFormatterPrint.string(from: date)
}

struct CurrencyDetail: View {
    @State var rates = ratesSample
    @State var startDate = Date()
    @State var endDate = Date()
    let currency: Currency
    init(currency: Currency) {
        self.currency = currency
    }
    var body: some View {
        ScrollView {
            VStack {
                DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                    Text("Select a start date")
                }
                DatePicker(selection: $endDate, in: ...Date(), displayedComponents: .date) {
                    Text("Select an end date")
                }
                Button(action: {
                    let start = formatDate(date: self.startDate)
                    let end = formatDate(date: self.endDate)
                    let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/\(table.table)/\(self.currency.code)/\(start)/\(end)/?format=json")!
                    print("Querying \(url)")
                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else { return }
                        let json = String(data: data, encoding: .utf8)!
                        do {
                            let result = try JSONDecoder().decode(Rates.self, from: json.data(using: .utf8)!)
                            self.rates = result
                        } catch {
                            print(error)
                        }
                    }

                    task.resume()
                }) {
                    Text("Get")
                }
                Text(self.rates.format())
            }
            .navigationBarTitle(Text(currency.currency), displayMode: .inline)
        }
    }
}

struct CurrencyDetail_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetail(currency: dolar)
    }
}
