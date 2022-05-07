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
        return imageObserver.eraseToAnyPublisher()
    }
    var resultPublisher: AnyPublisher<(expression: String, result: String), Never> {
        return resultSubject.eraseToAnyPublisher()
    }
    
    private var imageObserver = CurrentValueSubject<UIImage?, Never>(nil)
    private var resultSubject = PassthroughSubject<(expression: String, result: String), Never>()
    private var textExtractor: TextExtractor
    private var subscriptions = Set<AnyCancellable>()
    
    init(textExtractor: TextExtractor) {
        self.textExtractor = textExtractor
    }
    
    func processImage(_ image: UIImage) {
        imageObserver.send(image)
        textExtractor.extractText(from: image)
            .sink { [weak self] text in
                self?.processText(text)
            }
            .store(in: &subscriptions)
    }
    
    func processText(_ text: String) {
        print("Got text: \(text)")
        resultSubject.send((expression: text, result: "2"))
    }
}
