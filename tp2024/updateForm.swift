//
//  updateForm.swift
//  tp2024
//
//  Created by William Tomas on 06/03/2024.
//

import SwiftUI

struct updateForm: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var subscription: Subscription

    var body: some View {
        NavigationView {
            Form {
                TextField("Nom", text: $subscription.name)
                TextField("Prix", value: $subscription.price, format: .number)
                    .keyboardType(.decimalPad)
                DatePicker("Date de début", selection: $subscription.startDate, displayedComponents: .date)
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
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    updateForm()
//}
