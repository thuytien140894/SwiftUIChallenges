//
//  Measurement.swift
//  UnitConverter
//
//  Created by Tien Thuy Ho on 10/13/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

protocol MeasurementUnit: CustomStringConvertible {
    func unit(value: String) -> Measurement?
}

protocol Measurement {
    func convert(to unit: MeasurementUnit) -> Double
}
