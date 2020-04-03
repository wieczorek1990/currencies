//
//  ContentView.swift
//  currencies
//
//  Created by Łukasz Wieczorek on 03/04/2020.
//  Copyright © 2020 Łukasz Wieczorek. All rights reserved.
//

import SwiftUI

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
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
