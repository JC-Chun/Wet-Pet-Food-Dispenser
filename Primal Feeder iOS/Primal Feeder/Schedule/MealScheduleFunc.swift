//
//  Schedule.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/18/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import Foundation

class Schedule {
    static func createSchedule(mealSchedule: MealSchedule) {
        // schedule a meal to the upcoming list
        // REPLACE THIS CODE FOR THE DATA TO BE SAVED IN DATABASE
        Data.mealSchedules.append(mealSchedule)
    }
    static func createMeal(index: Int, mealList: MealList) {
        // REPLACE THIS CODE FOR THE DATA TO BE SAVED IN DATABASE
        if Data.mealSchedules.count == 0 {
            //Data.mealSchedules = MockData.createMockMealScheduleData()
            Data.mealSchedules.append(MealSchedule(title: "Upcoming", mealList: nil))
            Data.mealSchedules.append(MealSchedule(title: "Past", mealList: nil))
        }
        Data.mealSchedules[index].mealList.append(mealList)
        
    }
        
    
    static func listMeal(completion: @ escaping () -> ()) {
        // list meals in Meal List table view
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.mealSchedules.count == 0 {
                // REPLACE WITH REAL DATA
                Data.mealSchedules.append(MealSchedule(title: "Upcoming", mealList: MockData.createMockMealListData(sectionTitle: "Upcoming")))
                Data.mealSchedules.append(MealSchedule(title: "Past", mealList: MockData.createMockMealListData(sectionTitle: "Past")))
            }
        }
        DispatchQueue.main.async{
            completion();
        }
    }
    
    static func readMeal(by id: UUID, completion: @escaping (MealSchedule?) -> ()) {
        // read meal ID
        DispatchQueue.global(qos: .userInitiated).async {
            let meal = Data.mealSchedules.first(where: { $0.id == id })

            DispatchQueue.main.async {
                completion(meal)
            }
        }
    }
    
    static func moveToPast(completion: @ escaping () -> ()) {
        // move a meal from upcoming to past after food has been dispensed or an error has been raised
        DispatchQueue.global(qos: .userInteractive).async {
            
        }
        DispatchQueue.main.async {
            completion();
        }
    }
    
    static func deleteMeal(at scheduleIndex: Int, meal: MealList) {
        // delete a meal
        guard let index = Data.mealSchedules[scheduleIndex].mealList.firstIndex(of: meal) else { return }
        Data.mealSchedules[scheduleIndex].mealList.remove(at: index)
    }
    
}

