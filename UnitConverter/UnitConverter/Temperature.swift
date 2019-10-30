//
//  Temperature.swift
//  UnitConverter
//
//  Created by Tien Thuy Ho on 10/12/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

enum TemperatureUnit: String, MeasurementUnit {
    
    case celcius = "C"
    case farenheit = "F"
    case kelvin = "K"
    
    var description: String {
        return rawValue
    }
    
    func unit(value: String) -> Measurement? {
        
        switch self {
        case .celcius:
            return Celcius(value: value)
        case .farenheit:
            return Farenheit(value: value)
        case .kelvin:
            return Kelvin(value: value)
        }
    }
}

protocol Temperature: Measurement  {
    var celcius: Double { get }
    var farenheit: Double { get }
    var kelvin: Double { get }
}

extension Temperature {
    
    func convert(to unit: MeasurementUnit) -> Double {
        
        guard let temperatureUnit = unit as? TemperatureUnit else {
            return 0
        }
        
        switch temperatureUnit {
        case .celcius:
            return celcius
        case .farenheit:
            return farenheit
        case .kelvin:
            return kelvin
        }
    }
}

struct Celcius: Temperature {
    
    private var value: Double = 0
    
    init?(value: String) {
        
        guard let value = Double(value) else {
            return nil
        }
        
        self.value = value
    }
    
    var celcius: Double {
        return value
    }
    
    var farenheit: Double {
        return value * 9 / 5 + 32
    }
    
    var kelvin: Double {
        return value + 273.15
    }
}

struct Farenheit: Temperature {
    
    private var value: Double = 0
    
    init?(value: String) {
        guard let value = Double(value) else {
            return nil
        }
        
        self.value = value
    }
    
    var celcius: Double {
        return (value - 32) * 5 / 9
    }
    
    var farenheit: Double {
        return value
    }
    
    var kelvin: Double {
        return (value - 32) * 5 / 9 + 273.15
    }
}

struct Kelvin: Temperature {
    
    private var value: Double = 0
    
    init?(value: String) {
        guard let value = Double(value) else {
            return nil
        }
        
        self.value = value
    }
    
    var celcius: Double {
        return value - 273.15
    }
    
    var farenheit: Double {
        return (value - 273.15) * 9 / 5 + 32
    }
    
    var kelvin: Double {
        return value
    }
}
