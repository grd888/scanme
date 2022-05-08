//
//  ExpressionParserServiceTests.swift
//  ScanMeTests
//
//  Created by Greg Delgado III on 5/8/22.
//

import XCTest
@testable import ScanMe

class ExpressionParserServiceTests: XCTestCase {

    func test_parseAdditionExpression() {
        let inputs = ["6 + 5", "6.0 + 5.0", "6 + 5.0", "6.0 + 5"]
        
        inputs.forEach {
            let expression = makeSUT().parseExpression(string: $0)
            XCTAssertEqual(String(expression!.result), "11.0")
        }
    }
    
    func test_parseSubtractionExpression() {
        let inputs = ["6 - 5", "6.0 - 5.0", "6 - 5.0", "6.0 - 5"]
        
        inputs.forEach {
            let expression = makeSUT().parseExpression(string: $0)
            XCTAssertEqual(String(expression!.result), "1.0")
        }
    }
    
    func test_parseDivisionExpression() {
        let inputs = ["60 / 5", "60.0 / 5.0", "60 / 5.0", "60.0 / 5"]
        
        inputs.forEach {
            let expression = makeSUT().parseExpression(string: $0)
            XCTAssertEqual(String(expression!.result), "12.0")
        }
    }
    
    func test_parseMultiplicationExpression_UsingSymbol_x() {
        let inputs = ["6 x 5", "6.0 x 5.0", "6 x 5.0", "6.0 x 5"]
        
        inputs.forEach {
            let expression = makeSUT().parseExpression(string: $0)
            XCTAssertEqual(String(expression!.result), "30.0")
        }
    }
    
    func test_parseMultiplicationExpression_UsingSymbol_X() {
        let inputs = ["6 X 5", "6.0 X 5.0", "6 X 5.0", "6.0 X 5"]
        
        inputs.forEach {
            let expression = makeSUT().parseExpression(string: $0)
            XCTAssertEqual(String(expression!.result), "30.0")
        }
    }
    
    func test_parseMultiplicationExpression_UsingSymbol_star() {
        let inputs = ["6 * 5", "6.0 * 5.0", "6 * 5.0", "6.0 * 5"]
        
        inputs.forEach {
            let expression = makeSUT().parseExpression(string: $0)
            XCTAssertEqual(String(expression!.result), "30.0")
        }
    }
    
    // MARK: Helpers
    func makeSUT() -> ExpressionParser {
        ExpressionParserService()
    }
}
