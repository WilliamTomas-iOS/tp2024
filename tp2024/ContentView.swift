//
//  ContentView.swift
//  tp2024
//
//  Created by William Tomas on 04/03/2024.
//

import SwiftUI

struct ContentView: View {

    @State private var showAddView = false
    @State private var showTotal = false

    @State var subscriptions: [Subscription] = [.init(name: "Netflix", price: 20, startDate: .now)]

    var body: some View {
        NavigationStack {
            List {
                ForEach(subscriptions) { subscription in
                    NavigationLink(value: subscription) {
                        Text(subscription.name)
                    }
                }
            }
            .navigationTitle("Abonnements")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showTotal.toggle()
                    } label: {
                        Text("Total")
                    }
                }


                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: Subscription.self) { subscription in
                detail(subscription: subscription)
            }
            .sheet(isPresented: $showAddView) {
                form { name, price, date in
                    subscriptions.append(.init(name: name, price: price, startDate: date))
                }
            }
            .sheet(isPresented: $showTotal) {
                total(subscriptions: subscriptions)
                    .presentationDetents([.fraction(0.15)])
            }
        }
    }
}

#Preview {
    ContentView()
}
