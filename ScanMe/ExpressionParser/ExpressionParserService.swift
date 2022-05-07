//
//  ExpressionParserService.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/7/22.
//

import Foundation

struct ExpressionParserService: ExpressionParser {
    func parseExpression(string: String) -> Expression? {
        let components = string.components(separatedBy: " ")
        guard components.count >= 3 else {
            return nil
        }
        guard let operand1 = Double(components[0]) else {
            return nil
        }
        guard let operation = Operation(symbol: components[1]) else {
            return nil
        }
        guard let operand2 = Double(components[2]) else {
            return nil
        }
        return Expression(operand1: operand1, operand2: operand2, operation: operation)
    }
}
