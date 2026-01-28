//
//  Item.swift
//  budget-app-front-end
//
//  Created by Oliver Pruett on 1/28/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
