//
//  ScanMeViewModel.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/5/22.
//

import Foundation
import Combine

class ScanMeViewModel {
    var subscriptions = Set<AnyCancellable>()
    var imageService: ImageGetter
    
    init(imageService: ImageGetter) {
        self.imageService = imageService
    }
    
    func getInputImage() {
        imageService.getImage().sink { result in
            print(result)
        } receiveValue: { image in
            print("Got image: \(image)")
        }.store(in: &subscriptions)
    }
}
