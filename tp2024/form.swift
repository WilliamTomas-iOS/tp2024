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
    @Environment(\.dismiss) var dismiss
    var addMethod: (_ name: String, _ price: Double, _ date: Date) -> ()
    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $name)
                TextField("Prix", value: $price, format: .number)
                    .keyboardType(.decimalPad)
                DatePicker("Date de début", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Ajouter un abonnement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .confirmationAction) {
                    Button("OK") {
                        addMethod(name, price, date)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    form(addMethod: {_, _, _ in})
}
