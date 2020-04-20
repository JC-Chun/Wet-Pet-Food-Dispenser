//
//  DateExtension.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/12/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import Foundation

extension Date {
    func addDayAndTime(days: Int, hours: Int, mins: Int) -> Date {
        let now = Date()
        var dateComponent = DateComponents()
        dateComponent.day = days
        dateComponent.hour = hours
        dateComponent.minute = mins
        let newDay = Calendar.current.date(byAdding: dateComponent, to: now)!
        return newDay
    }
}
