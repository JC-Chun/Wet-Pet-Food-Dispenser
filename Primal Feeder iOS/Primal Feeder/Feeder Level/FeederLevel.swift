//
//  FeederLevel.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/5/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import Foundation

class FeederLevel {
    let id: UUID
    var title = "" // "Food" or "Water"
    var level = ""
    
    init(title: String, level: String) {
        id = UUID()
        self.title = title
        self.level = level
    }
}
