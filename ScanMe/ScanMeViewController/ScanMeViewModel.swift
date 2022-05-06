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
    private var imageObserver = CurrentValueSubject<UIImage?, Never>(nil)
    private var imageService: ImageGetter
    
    init(imageService: ImageGetter) {
        self.imageService = imageService
    }
    
    func processImage(_ image: UIImage) {
        print("Got image!: \(image)")
        imageObserver.send(image)
    }
}
