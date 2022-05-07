//
//  ExpressionParser.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/7/22.
//

import Foundation

protocol ExpressionParser {
    func parseExpression(string: String) -> Expression?
}
