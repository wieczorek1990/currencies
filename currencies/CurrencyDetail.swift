//
//  CurrencyDetail.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 04/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

import SwiftUI

struct CurrencyDetail: View {
    let currency: Currency
    init(currency: Currency) {
        self.currency = currency
    }
    var body: some View {
        VStack{
            Text("Hello world!")
        }
        .navigationBarTitle(Text(currency.currency), displayMode: .inline)
    }
}

struct CurrencyDetail_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyDetail(currency: dolar)
    }
}
