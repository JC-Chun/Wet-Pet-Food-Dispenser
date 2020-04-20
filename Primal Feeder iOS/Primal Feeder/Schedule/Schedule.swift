//
//  Schedule.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/18/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import Foundation

class Schedule {
    static func createMeal(mealSchedule: MealSchedule) {
        // schedule a meal
    }
    
    static func listMeal(completion: @ escaping () -> ()) {
        // list meals in Meal List table view
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.mealSchedules.count == 0 {
                Data.mealSchedules = MockData.createMockMealScheduleData()
            }
        }
        DispatchQueue.main.async{
            completion();
        }
    }
    
//    static func readMealID(by id: UUID, completion: @escaping (MealSchedule?) -> ()) {
//        // read meal ID
//        DispatchQueue.global(qos: .userInitiated).async {
//            let meal = Data.tripModels.first(where: { $0.id == id })
//
//            DispatchQueue.main.async {
//                completion(meal)
//            }
//        }
//    }
    
    static func sendMeal() {
        // request to post JSON
        
    }
    
    static func getMeal() {
        // request to get JSON
        
    }
    
    static func notify() {
        // create a notification when data indicates that food has been dispensed
        
    }
    
    static func move2Past(completion: @ escaping () -> ()) {
        // move a meal from upcoming to past after food has been dispensed or an error has been raised
        DispatchQueue.global(qos: .userInteractive).async {
            
        }
        DispatchQueue.main.async{
            completion();
        }
    }
    
    static func deletePastMeal() {
        // delete past meals
        
    }
    
    static func swipeDeleteMeal(index: Int) {
        // user deletes a meal
        Data.mealSchedules.remove(at: index)
    }
}

