//
//  GoogleMLService.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/7/22.
//

import UIKit
import Combine

class GoogleMLService: TextExtractor {
    func extractText(from image: UIImage) -> Future<String, Never> {
        return Future<String,Never> { promise in
            promise(.success("1 + 1"))
        }
    }
}
