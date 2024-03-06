//
//  detail.swift
//  tp2024
//
//  Created by William Tomas on 05/03/2024.
//

import SwiftUI

struct detail: View {
    @State var total: Double
    var subscription: Subscription

    @State var showUpdateView: Bool = false

    init(subscription: Subscription) {
        self.subscription = subscription
        let startDateComponents = Calendar.current.dateComponents([.year, .month], from: subscription.startDate)
        let endDateComponents = Calendar.current.dateComponents([.year, .month], from: .now)
        let diffInDate = Calendar.current.dateComponents([.month], from: startDateComponents, to: endDateComponents).month!
        total = subscription.price * Double(diffInDate+1)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(subscription.name)
                .font(.largeTitle)
                .bold()

            Spacer()

            HStack {
                Text("🕰️")
                Spacer()
                Text(subscription.startDate.addingTimeInterval(0), style: .date)
            }

            HStack {
                Text("💶")
                Spacer()
                Text("\(subscription.price, specifier: "%.2f")€")
            }

            HStack {
                Text("Cout total :")
                    .bold()
                Spacer()
                Text("\(total, specifier: "%.2f")€")
                    .bold()
            }

            Spacer()

            Button("Modifier", action: {
                showUpdateView.toggle()
            })
        }
        .padding()
        .sheet(isPresented: $showUpdateView, content: {
            updateForm(subscription: subscription)
        })
    }
}

#Preview {
    detail(subscription: .init(name: "Netflix", price: 20, startDate: .now))
}
