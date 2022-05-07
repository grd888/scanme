//
//  TextExtractor.swift
//  ScanMe
//
//  Created by Greg Delgado III on 5/7/22.
//

import Foundation
import UIKit
import Combine

enum ImageError: Error {
    case invalidImage
}
protocol TextExtractor {
    func extractText(from image: UIImage) -> Future<String, Never>
}
