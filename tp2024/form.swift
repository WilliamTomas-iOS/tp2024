//
//  form.swift
//  tp2024
//
//  Created by William Tomas on 05/03/2024.
//

import SwiftUI

struct form: View {
    @State var name: String = ""
    @State var price: Double = 0.0
    @State var date: Date = Date()
    
    var body: some View {
        Form {
            TextField("Nom", text: $name)
            TextField("Prix", value: $price, format: .number)
                .keyboardType(.decimalPad)
            DatePicker("Date de début", selection: $date, displayedComponents: .date)
        }
    }
}

#Preview {
    form()
}
