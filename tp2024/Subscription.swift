//
//  Subscription.swift
//  tp2024
//
//  Created by William Tomas on 04/03/2024.
//

import Foundation
import SwiftData

@Model
class Subscription: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var price: Double
    var startDate: Date

    init(name: String, price: Double, startDate: Date) {
        self.name = name
        self.price = price
        self.startDate = startDate
    }
}
