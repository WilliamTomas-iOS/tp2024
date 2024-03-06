//
//  ContentView.swift
//  tp2024
//
//  Created by William Tomas on 04/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @State private var showAddView = false
    @State private var showTotal = false

    @Query var subscriptions: [Subscription] = []

    @Environment(\.modelContext) var context

    var body: some View {
        NavigationStack {
            List {
                ForEach(subscriptions) { subscription in
                    NavigationLink(value: subscription) {
                        Text(subscription.name)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(subscriptions[index])
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
                    let sub = Subscription(name: name, price: price, startDate: date)
                    context.insert(sub)
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
