//
//  total.swift
//  tp2024
//
//  Created by William Tomas on 05/03/2024.
//

import SwiftUI

struct total: View {
    var subscriptions: [Subscription]
    var totalMois: Double = 0

    init(subscriptions: [Subscription]) {
        self.subscriptions = subscriptions
        subscriptions.forEach { subscription in
            totalMois += subscription.price
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text("\(totalMois, specifier: "%.2f") €")
                    .font(.title)
                    .bold()
                Spacer()
            }
            Text("Vous avez \(subscriptions.count) abonnements en cours")
            Text("Soit \(totalMois * 12, specifier: "%.2f")€ à l'année")
        }
        .padding()
    }
}

#Preview {
    total(subscriptions: [])
}
