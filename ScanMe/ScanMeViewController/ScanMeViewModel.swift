//
//  ScanMeViewModel.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import Foundation
import Combine
import UIKit

class ScanMeViewModel {

    var imagePublisher: AnyPublisher<UIImage?, Never> {
        return imageSubject.eraseToAnyPublisher()
    }
    var resultPublisher: AnyPublisher<(expression: String, result: String), Never> {
        return resultSubject.eraseToAnyPublisher()
    }
    
    private var imageSubject = PassthroughSubject<UIImage?, Never>()
    private var resultSubject = PassthroughSubject<(expression: String, result: String), Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private var textExtractor: TextExtractor
    private var parser: ExpressionParser
    
    init(textExtractor: TextExtractor, parser: ExpressionParser) {
        self.textExtractor = textExtractor
        self.parser = parser
    }
    
    func processImage(_ image: UIImage) {
        imageSubject.send(image)

        textExtractor.extractText(from: image)
            .sink { [weak self] text in
                self?.processText(text)
            }
            .store(in: &subscriptions)
    }
    
    func processText(_ text: String) {
        if let expression = parser.parseExpression(string: text) {
            resultSubject.send((expression: expression.expression, result: String(expression.result)))
        } else {
            resultSubject.send((expression: "Invalid", result: "----"))
        }
        
    }
}
