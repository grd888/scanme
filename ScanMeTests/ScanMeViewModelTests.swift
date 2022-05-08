//
//  ScanMeViewModelTests.swift
//  ScanMeTests
//
//  Created by Greg Delgado III on 5/8/22.
//

import XCTest
import Combine
@testable import ScanMe

class ScanMeViewModelTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        subscriptions = []
    }
    
    func test_imagePublisher() {
        let sut = makeSUT()
        let targetImage =  UIImage(systemName: "pin")!
        let exp = expectation(description: "Waiting for image...")
        
        sut.imagePublisher.sink { image in
            exp.fulfill()
            XCTAssertEqual(image, targetImage)
            
        }
        .store(in: &subscriptions)
        
        sut.processImage(targetImage)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_resultPublisher() {
        let sut = makeSUT()
        let expectedText = "Random Text"
        let exp = expectation(description: "Waiting for result...")
        
        sut.resultPublisher.sink { output in
            exp.fulfill()
            XCTAssertEqual(output.expression, "Invalid")
        }
        .store(in: &subscriptions)
        
        sut.processText(expectedText)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_resultPublisher_withValidInput() {
        let expressionParser = MockParser()
        let sut = makeSUT(parser: expressionParser)
        
        let inputText = "5 + 5"
        expressionParser.complete(with: Expression(operand1: 5.0, operand2: 5.0, operation: .add))
        
        let exp = expectation(description: "Waiting for result...")
        
        sut.resultPublisher.sink { output in
            
            XCTAssertEqual(output.expression, "5.0 + 5.0")
            exp.fulfill()
        }
        .store(in: &subscriptions)
        
        sut.processText(inputText)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: Helpers
    func makeSUT(parser: ExpressionParser = MockParser()) -> ScanMeViewModel {
        let viewModel = ScanMeViewModel(textExtractor: MockTextExtractor(), parser: parser)
        return viewModel
    }
}

private class MockParser: ExpressionParser {
    var expression: Expression?
    
    func complete(with expression: Expression) {
        self.expression = expression
    }
    
    func parseExpression(string: String) -> Expression? {
        return expression
    }
}

private class MockTextExtractor: TextExtractor {
    var resultString: String?
    
    func complete(with string: String) {
        self.resultString = string
    }
    
    func extractText(from image: UIImage) -> Future<String, Never> {
        return Future { [resultString] promise in
            promise(.success(resultString ?? ""))
        }
    }
}
