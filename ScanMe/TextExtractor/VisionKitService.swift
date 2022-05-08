//
//  VisionKitService.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/8/22.
//

import UIKit
import VisionKit
import Combine
import Vision

class VisionKitService: TextExtractor {
    func extractText(from image: UIImage) -> Future<String, Never> {
        return Future { promise in
            guard let cgImage = image.cgImage else {
                promise(.success("Invalid Image."))
                return
            }
            let request = VNRecognizeTextRequest { request, error in
                DispatchQueue.main.async {
                    if error != nil {
                        promise(.success("OCR Failure"))
                        return
                    } else {
                        if let observation = request.results?.first as? VNRecognizedTextObservation,
                           let text = observation.topCandidates(1).first {
                            promise(.success(text.string))
                        } else {
                            promise(.success(""))
                        }
                    }
                }
            }
            request.recognitionLevel = .accurate
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch let error {
                    print("Error: \(error)")
                    promise(.success("OCR Failure"))
                }
            }
        }
    }
}
