//
//  CurrentDate.swift
//  realmTest
//
//  Created by Skander Jabouzi on 2018-01-25.
//  Copyright © 2018 Skander Jabouzi. All rights reserved.
//

import Foundation

class CurrentDate: NSObject {
    var date = Date()
    var calendar = Calendar.current
    
    public static let sharedInstance = CurrentDate()
    
    private override init() {
        super.init()
    }
    
    private func resetDate() {
        date = Date()
        calendar = Calendar.current
    }
    
    public func getCurrentDate() -> String {
        resetDate()
        let year: Int = calendar.component(.year, from: date)
        let month:Int = calendar.component(.month, from: date)
        let day:Int = calendar.component(.day, from: date)
        
        return "\(year)-\(month)-\(day)"
    }
    
    public func getCurrentTime() -> String {
        resetDate()
        let hours: Int = calendar.component(.hour, from: date)
        let minutes: Int = calendar.component(.minute, from: date)
        let seconds: Int = calendar.component(.second, from: date)
        
        return "\(hours):\(minutes):\(seconds)"
    }
    
}
