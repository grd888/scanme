//
//  Expression.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/7/22.
//

import Foundation

struct Expression {
    let operand1: Double
    let operand2: Double
    let operation: Operation
    
    var expression: String {
        "\(operand1) \(operation.rawValue) \(operand2)"
    }
    
    var result: Double {
        switch operation {
        case .add:
            return operand1 + operand2
        case .subtract:
            return operand1 - operand2
        case .multiply:
            return operand1 * operand2
        case .divide:
            return operand1 / operand2
        }
    }
}

enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
    
    init?(symbol: String) {
        switch symbol {
        case "+":
            self = .add
        case "-":
            self = .subtract
        case "x", "X", "*":
            self = .multiply
        case "/":
            self = .divide
        default:
            return nil
        }
    }
}
