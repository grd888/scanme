//
//  GoogleMLService.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/7/22.
//

import UIKit
import Combine
import MLKit

class GoogleMLService: TextExtractor {
    func extractText(from image: UIImage) -> Future<String, Never> {
        return Future<String,Never> { promise in
            let textRecognizer = TextRecognizer.textRecognizer()
            let visionImage = VisionImage(image: image)
            visionImage.orientation = image.imageOrientation
            
            textRecognizer.process(visionImage) { result, error in
                if let result = result, let block = result.blocks.first, let line = block.lines.first {
                    promise(.success(line.text))
                }
            }
            
        }
    }
}
