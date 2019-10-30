//
//  MultiplicationQuestion.swift
//  Edutainment
//
//  Created by Tien Thuy Ho on 10/28/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

struct MultiplicationQuestion {
    
    var firstOperand = 0
    var secondOperand = 0
    
    var answer: Int {
        return firstOperand * secondOperand
    }
}

enum NumberOfQuestions: String, CustomStringConvertible {
    
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case all = "All"
    
    var description: String {
        return rawValue
    }
    
    func toInt() -> Int? {
        
        switch self {
        case .five:
            return 5
        case .ten:
            return 10
        case .twenty:
            return 20
        default:
            return nil
        }
    }
}
