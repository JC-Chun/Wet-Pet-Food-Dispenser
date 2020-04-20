//
//  MockData.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/27/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//
//
// This is a temporary data source.

import Foundation

class MockData {
    static func createMockMealScheduleData() -> [MealSchedule] {
        var mockSchedules = [MealSchedule]()
        mockSchedules.append(MealSchedule(title: "Upcoming", mealList: createMockMealListData(sectionTitle: "Upcoming")))
            
        mockSchedules.append(MealSchedule(title: "Past", mealList: createMockMealListData(sectionTitle: "Past")))
        return mockSchedules
    }
    
    static func createMockMealListData(sectionTitle: String) -> [MealList] {
        var mockMealList = [MealList]()
        if sectionTitle == "Upcoming" {
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: 0, hours: 0, mins: 1), portion: "2 1/2 cups"))
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: 1, hours: 0, mins: 30),  portion: "3 cups"))
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: 1, hours: 12, mins: 45), portion: "3 1/4 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 13, 2020 5:30 pm", portion: "2.5 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 14, 2020 7:00 am",  portion: "3 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 14, 2020 6:45 pm", portion: "3.25 cups"))
        }
        else {
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: -1, hours: 0, mins: 45), portion: "3 3/8 cups"))
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: -2, hours: 3, mins: 0), portion: "2 1/5 cups"))
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: -3, hours: 0, mins: 30), portion: "2 1/8 cups"))
            mockMealList.append(MealList(dateAndTime: Date().addDayAndTime(days: -5, hours: 2, mins: 15), portion: "5 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 11, 2020 8:15 am", portion: "3.75 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 10, 2020 5:30 pm", portion: "2.5 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 9, 2020 9:00 pm", portion: "2.125 cups"))
//            mockMealList.append(MealList(dateAndTime: "Apr 8, 2020 7:40 pm", portion: "5.23 cups"))
        }
        
        return mockMealList
    }
    
    // Feeder water and nugget level mock data
    static func createMockFeederLevelData() -> [FeederLevel] {
        var mockLevel = [FeederLevel]()
        mockLevel.append(FeederLevel(title: "Nuggets", level: "75"))
        mockLevel.append(FeederLevel(title: "Water", level: "25"))
        
        return mockLevel
    }
    
    
}
