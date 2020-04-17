//
//  MealSchedule.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/4/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import SwiftUI

struct MealSchedule: Codable, Identifiable {
    let id: UUID
    var title = "" // section title: "Upcoming" or "Past"
    var mealList = [MealList]() {
        didSet {
            mealList = mealList.sorted(by: < )
        }
    }
    init(title: String, mealList: [MealList]? = nil) {
        id = UUID()
        self.title = title
        
        if let mealList = mealList {
            self.mealList = mealList
        }
            
    }
}

struct MealList: Codable, Equatable {
    var id: String!
    var dateAndTime = Date()
    var portion = ""
    
    init(dateAndTime: Date, portion: String) {
        id = UUID().uuidString
        self.dateAndTime = dateAndTime
        self.portion = portion
    }
}


extension MealList: Comparable {
    static func < (lhs: MealList, rhs: MealList) -> Bool {
        return lhs.dateAndTime < rhs.dateAndTime
    }
    
    static func == (lhs: MealList, rhs: MealList) -> Bool {
        return lhs.dateAndTime == rhs.dateAndTime
    }
}

struct Portion {
    var portionInt: [String]
    var portionFraction: [String]
    
    init(portionInt: String, portionFraction: String) {
        self.portionInt = [portionInt]
        self.portionFraction = [portionFraction]
    }
}

