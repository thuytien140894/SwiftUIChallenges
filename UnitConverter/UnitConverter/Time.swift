//
//  Time.swift
//  UnitConverter
//
//  Created by Tien Thuy Ho on 10/13/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

enum TimeUnit: String, MeasurementUnit {
    
    case day = "day"
    case hour = "hr"
    case minute = "min"
    
    var description: String {
        return rawValue
    }
    
    func unit(value: String) -> Measurement? {
        
        switch self {
        case .day:
            return Day(value: value)
        case .hour:
            return Hour(value: value)
        case .minute:
            return Minute(value: value)
        }
    }
}

protocol Time: Measurement {
    var days: Double { get }
    var hours: Double { get }
    var minutes: Double { get }
}

extension Time {
    
    func convert(to unit: MeasurementUnit) -> Double {
        
        guard let timeUnit = unit as? TimeUnit else {
            return 0
        }
        
        switch timeUnit {
        case .day:
            return days
        case .hour:
            return hours
        case .minute:
            return minutes
        }
    }
}

struct Day: Time {
    
    private var value: Double = 0
    
    init?(value: String) {
        
        guard let value = Double(value) else {
            return nil
        }
        
        self.value = value
    }
    
    var days: Double {
        return value
    }
    
    var hours: Double {
        return value * 24
    }
    
    var minutes: Double {
        return value * 24 * 60
    }
}

struct Hour: Time {
    
    private var value: Double = 0
    
    init?(value: String) {
        
        guard let value = Double(value) else {
            return nil
        }
        
        self.value = value
    }
    
    var days: Double {
        return value / 24
    }
    
    var hours: Double {
        return value
    }
    
    var minutes: Double {
        return value * 60
    }
}

struct Minute: Time {
    
    private var value: Double = 0
    
    init?(value: String) {
        
        guard let value = Double(value) else {
            return nil
        }
        
        self.value = value
    }
    
    var days: Double {
        return value / 60 / 24
    }
    
    var hours: Double {
        return value / 60
    }
    
    var minutes: Double {
        return value
    }
}
