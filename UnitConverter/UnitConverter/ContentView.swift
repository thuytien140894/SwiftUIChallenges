//
//  ContentView.swift
//  UnitConverter
//
//  Created by Tien Thuy Ho on 10/12/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import SwiftUI

enum MeasurementUnitType: String {
    case temperature = "Temperature"
    case time = "Time"
}

struct ContentView: View {
    
    @State private var inputUnitIndex = 0
    @State private var inputValue = ""
    
    @State private var outputUnitIndex = 0
    private var outputValue: Double {
        guard
            let selectedUnits = units[unitType] else {
            return 0
        }
        
        let inputUnit = selectedUnits[inputUnitIndex]
        let outputUnit = selectedUnits[outputUnitIndex]
        
        guard let measurement = inputUnit.unit(value: inputValue) else {
            return 0
        }
        return measurement.convert(to: outputUnit)
    }
    
    @State private var unitType: MeasurementUnitType = .temperature
    private var unitTypes: [MeasurementUnitType] = [.temperature, .time]
    
    private var units: [MeasurementUnitType: [MeasurementUnit]] {
        return [
            .temperature: [TemperatureUnit.celcius, TemperatureUnit.farenheit, TemperatureUnit.kelvin],
            .time: [TimeUnit.day, TimeUnit.hour, TimeUnit.minute]
        ]
    }
    
    private var selectedUnits: [MeasurementUnit] {
        return units[unitType] ?? []
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit Types", selection: $unitType) {
                        ForEach(unitTypes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    TextField("Input", text: $inputValue)
                        .keyboardType(.numberPad)
                    Picker("Input unit", selection: $inputUnitIndex) {
                        ForEach(0..<selectedUnits.count) {
                            Text(self.selectedUnits[$0].description)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .id(unitType)
                }
                
                Section {
                    Text("\(outputValue, specifier: "%.2f")")
                    Picker("Output unit", selection: $outputUnitIndex) {
                        ForEach(0..<selectedUnits.count) {
                            Text(self.selectedUnits[$0].description)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .id(unitType)
                }
            }.navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
