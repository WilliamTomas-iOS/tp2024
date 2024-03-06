//
//  Subscription.swift
//  tp2024
//
//  Created by William Tomas on 04/03/2024.
//

import Foundation

struct Subscription: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var price: Double
    var startDate: Date
}
