//
//  FeederLevel.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/5/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import Foundation

class Level {
    static func getLevels(completion: @ escaping () -> ()) {
        // list meals in Meal List table view
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.feederLevels.count == 0 {
                Data.feederLevels = MockData.createMockFeederLevelData()
            }
        }
        DispatchQueue.main.async{
            completion();
        }
    }
    
}
